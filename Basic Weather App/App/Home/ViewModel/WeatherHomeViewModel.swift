//
//  WeatherHomeViewModel.swift
//  Basic Weather App
//
//  Created by Ayan Chakraborty on 05/04/23.
//

import Foundation
import Combine
import CoreLocation
import UIKit


class WeatherHomeViewModel: NSObject, ObservableObject {
    // Published properties that can be observed by the views
    @Published var error: Error?
    @Published var weatherData: WeatherData? {
        didSet {
            // Fetch the weather icon when the weatherData is set
            fetchWeatherIcon()
        }
    }
    @Published var currentCity: String = "Loading"
    @Published var weatherIcon: UIImage?
    @Published var isNight: Bool = true
    
    // Location manager to get the user's location
    let locationManager = CLLocationManager()
    // Model to get weather data
    private let model: WeatherHomeModelProtocol
    
    // Initializer
    init(model: WeatherHomeModelProtocol) {
        self.model = model
        super.init()
        // Set the delegate and request location authorization
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        // Load the weather data for the last searched city or current location
        loadWeatherData()
    }
    
    // Load the weather data for the last searched city or current location
    func loadWeatherData() {
        if let lastSearchedCity = UserDefaults.standard.string(forKey: "kLastSearchedCityKey") {
            // Fetch the weather data for the last searched city
            Task {
                await fetchWeatherData(for: lastSearchedCity)
            }
        } else {
            // Start updating the location to fetch the current location's weather data
            self.locationManager.startUpdatingLocation()
        }
    }
    
    // Fetch the weather data for the given city, state, and country code
    func fetchWeatherData(for city: String,
                          state: String? = nil,
                          countryCode: String? = nil) async {
        do {
            // Store the searched city in user defaults
            UserDefaults.standard.set(city, forKey: "kLastSearchedCityKey")
            // Get the latitude and longitude of the searched location
            let (latitude, longitude) = try await getLocationFromAddress(city: city,
                                                                         state: state,
                                                                         countryCode: countryCode)
            // Fetch the weather data for the latitude and longitude
            let weatherData = try await model.fetchWeatherData(latitude: latitude,
                                                               longitude: longitude)
            // Update the weatherData and currentCity on the main queue
            DispatchQueue.main.async {
                self.weatherData = weatherData
                self.currentCity = weatherData.name ?? "Unknown"
                if let icon = weatherData.weather?.first?.icon {
                    if icon.contains("n") {
                        self.isNight = true
                    } else {
                        self.isNight = false
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // Get the latitude and longitude for the given address
    private func getLocationFromAddress(city: String,
                                        state: String?,
                                        countryCode: String?) async throws -> (Double, Double) {
        let geocoder = CLGeocoder()
        var address = city
        if let state = state {
            address += ", \(state)"
        }
        if let countryCode = countryCode {
            address += ", \(countryCode)"
        }
        do {
            // Geocode the address to get the placemarks
            let placemarks = try await geocoder.geocodeAddressString(address)
            // Get the first placemark's location coordinate
            guard let placemark = placemarks.first,
                  let location = placemark.location else {
                throw NetworkError.invalidURL
            }
            let coordinate = location.coordinate
            return (coordinate.latitude, coordinate.longitude)
        } catch {
            throw error
        }
    }
    
    // Get the city name for the given location
    func getCityFromLocation(for location: CLLocation) async throws -> String {
        let geocoder = CLGeocoder()
        let placemarks = try await geocoder.reverseGeocodeLocation(location)
        guard let placemark = placemarks.first else {
            throw NetworkError.invalidURL
        }
        let city = placemark.locality ?? placemark.administrativeArea ?? placemark.country ?? "Unknown"
        return city
    }
    
    // This function fetches the icon for the current weather data from a remote source
    func fetchWeatherIcon() {
        guard let iconName = weatherData?.weather?.first?.icon else { return }
        Task {
            do {
                let data = try await model.fetchIcon(icon: iconName)
                guard let image = UIImage(data: data) else {
                    throw NSError(domain: "Image error", code: 445)
                }
                DispatchQueue.main.async {
                    self.weatherIcon = image
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    // This function determines whether it is night time or not for a given date
    func isNight(for date: Date = Date()) -> Bool {
        let calendar = Calendar.current
        let sunrise = calendar.date(bySettingHour: 6, minute: 0, second: 0, of: date)!
        let sunset = calendar.date(bySettingHour: 18, minute: 0, second: 0, of: date)!
        return date < sunrise || date > sunset
    }
    
    // This function converts the temperature in Kelvin to the desired unit (Celsius or Fahrenheit) and returns it as a formatted string
    func convertTemperature(to unit: String) -> String {
        var convertedTemperature: Double = 0
        guard let kelvin = weatherData?.main?.temp else { return "--"}
        switch unit.lowercased() {
        case "c":
            convertedTemperature = kelvin - 273.15
        case "f":
            convertedTemperature = (kelvin - 273.15) * 9/5 + 32
        default:
            print("Invalid unit parameter")
        }
        return  String(format: "%.1f", convertedTemperature)+"°\(unit.uppercased())"
    }
    
    // This function determines whether it is currently raining or not based on the weather description of the current weather data
    func isRaining() -> Bool {
        guard let description = weatherData?.weather?.first?.description else { return false }
        if description.lowercased().contains("rain") {
            return true
        }
        return false
    }
    
}
