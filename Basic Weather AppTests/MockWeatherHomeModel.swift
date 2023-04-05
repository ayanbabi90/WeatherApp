//
//  MockWeatherHomeModel.swift
//  Basic Weather AppTests
//
//  Created by Ayan Chakraborty on 06/04/23.
//

import Foundation
import UIKit
@testable import Basic_Weather_App

class MockWeatherHomeModel: WeatherHomeModelProtocol {
    
    var weatherData: WeatherData?
    var error: Error?
    var weatherIcon: UIImage?
    
    func fetchWeatherData(latitude: Double, longitude: Double) async throws -> WeatherData {
        if let error = error {
            throw error
        }
        weatherData = mockWeatherData()
        guard let weatherData = weatherData else {
            throw NSError(domain: "MockWeatherHomeModel error", code: 444)
        }
        return weatherData
    }
    
    func fetchIcon(icon: String) async throws -> Data {
        let playImage = UIImage(systemName: "play.fill")
        return playImage?.pngData() ?? Data()
    }
    
    func mockWeatherData() -> WeatherData {
        return WeatherData(weather: [Weather(id: 0,
                                             main: "Mock weather",
                                             description: "Mock weather",
                                             icon:  "10n")],
                           base: "Mock base",
                           main: Main(temp: 290.15,
                                      feelsLike: 20,
                                      tempMin: 290.15,
                                      tempMax: 20,
                                      pressure: 11,
                                      humidity: 22,
                                      seaLevel: 0,
                                      grndLevel: 0),
                           visibility: 0,
                           wind: Wind(speed: 22, deg: 2, gust: 2),
                           name: "Mock name",
                           cod: 0)
    }
}
