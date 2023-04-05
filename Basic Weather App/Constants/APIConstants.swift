//
//  APIConstants.swift
//  Basic Weather App
//
//  Created by Ayan Chakraborty on 06/04/23.
//

import Foundation


enum NetworkError: Error {
    case invalidURL
    case noData
}

enum API {
    static let scheme = "https"
    static let host = "api.openweathermap.org"
    static let path = "/data/2.5"
    static let apiKey = "84a1b5f508af9d8cbfa5641382cb9dbe"
    
    case fetchWeatherData(latitude: Double, longitude: Double)
    case fetchIcon(icon: String)
    
    var url: URL? {
        switch self {
        case .fetchWeatherData(let latitude, let longitude):
            var components = URLComponents()
            components.scheme = API.scheme
            components.host = API.host
            components.path = API.path + "/weather"
            components.queryItems = [
                URLQueryItem(name: "lat", value: "\(latitude)"),
                URLQueryItem(name: "lon", value: "\(longitude)"),
                URLQueryItem(name: "appid", value: API.apiKey)
            ]
            return components.url
        case .fetchIcon(let icon):
            let urlString = "https://openweathermap.org/img/wn/\(icon)@2x.png"
            return URL(string: urlString)
        }
    }
    
    var request: URLRequest? {
        guard let url = self.url else { return nil }
        return URLRequest(url: url)
    }
}
