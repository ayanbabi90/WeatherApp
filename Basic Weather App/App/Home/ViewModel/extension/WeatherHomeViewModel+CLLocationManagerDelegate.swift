//
//  WeatherHomeViewModel+CLLocationManagerDelegate.swift
//  Basic Weather App
//
//  Created by Ayan Chakraborty on 06/04/23.
//

import Foundation
import CoreLocation
import UIKit



extension WeatherHomeViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        if let lastSearchedCity = UserDefaults.standard.string(forKey: "kLastSearchedCityKey") {
            Task {
                await fetchWeatherData(for: lastSearchedCity)
            }
        } else {
            Task {
                do {
                    let city = try await getCityFromLocation(for: location)
                    DispatchQueue.main.async {
                        self.currentCity = city
                    }
                    await self.fetchWeatherData(for: city)
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            self.locationManager.startUpdatingLocation()
        }
    }
    
}
