//
//  WeatherHomeModel.swift
//  Basic Weather App
//
//  Created by Ayan Chakraborty on 05/04/23.
//

import Foundation


protocol WeatherHomeModelProtocol {
    func fetchWeatherData(latitude: Double, longitude: Double) async throws -> WeatherData
    func fetchIcon(icon: String) async throws -> Data
}

struct WeatherHomeModel: WeatherHomeModelProtocol {
    
    func fetchWeatherData(latitude: Double, longitude: Double) async throws -> WeatherData {
        guard let request = API.fetchWeatherData(latitude: latitude, longitude: longitude).request else {
            throw NSError(domain: "URL error", code: 444)
        }
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
            return weatherData
        } catch {
            throw error
        }
    }
    
    func fetchIcon(icon: String) async throws -> Data {
        guard let request = API.fetchIcon(icon: icon).request else {
            throw NSError(domain: "URL error", code: 444)
        }
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return data
        } catch {
            throw error
        }
    }
 
}

