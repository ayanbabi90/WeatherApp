//
//  WeatherData.swift
//  Basic Weather App
//
//  Created by Ayan Chakraborty on 06/04/23.
//

import Foundation

// MARK: - WeatherData
struct WeatherData: Codable, Equatable {
    
    let weather: [Weather]?
    let base: String?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let name: String?
    let cod: Int?
    
    static func == (lhs: WeatherData, rhs: WeatherData) -> Bool {
        return lhs.main?.temp == rhs.main?.temp && lhs.name == rhs.name
    }
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double?
    let pressure, humidity, seaLevel, grndLevel: Int?
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike
        case tempMin
        case tempMax
        case pressure, humidity
        case seaLevel
        case grndLevel
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int?
    let main, description, icon: String?
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
}
