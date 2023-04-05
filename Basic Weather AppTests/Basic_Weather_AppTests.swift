//
//  Basic_Weather_AppTests.swift
//  Basic Weather AppTests
//
//  Created by Ayan Chakraborty on 05/04/23.
//

import XCTest
@testable import Basic_Weather_App

final class Basic_Weather_AppTests: XCTestCase {

    func testWeatherHomeViewModelInitialization() {
        let mockModel = MockWeatherHomeModel()
        let viewModel = WeatherHomeViewModel(model: mockModel)
        XCTAssertEqual(viewModel.currentCity, "Loading")
        XCTAssertNil(viewModel.weatherData)
        XCTAssertNil(viewModel.weatherIcon)
        XCTAssertNil(viewModel.error)
        XCTAssertNotNil(viewModel.locationManager.delegate)
    }

    func testFetchWeatherData() async {
        let expectation = XCTestExpectation(description: "Fetch weather data")
        let mockModel = MockWeatherHomeModel()
        let viewModel = WeatherHomeViewModel(model: mockModel)
        await viewModel.fetchWeatherData(for: "New York")
        viewModel.fetchWeatherIcon()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertNotNil(viewModel.weatherData)
            XCTAssertNotNil(viewModel.weatherIcon)
            XCTAssertFalse(viewModel.currentCity.isEmpty)
            XCTAssertNil(viewModel.error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }

    func testFetchWeatherIcon() {
        let expectation = XCTestExpectation(description: "Fetch weather icon")
        let viewModel = WeatherHomeViewModel(model: MockWeatherHomeModel())
        viewModel.fetchWeatherIcon()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertNotNil(viewModel.weatherIcon)
            XCTAssertNil(viewModel.error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testConvertTemperature() {
        let mockModel = MockWeatherHomeModel()
        let viewModel = WeatherHomeViewModel(model: mockModel)
        viewModel.weatherData = mockModel.mockWeatherData()
        let celsius = viewModel.convertTemperature(to: "C")
        XCTAssertEqual(celsius, "17.0°C")
        let fahrenheit = viewModel.convertTemperature(to: "F")
        XCTAssertEqual(fahrenheit, "62.6°F")
    }

    func testIsNight() {
        let mockModel = MockWeatherHomeModel()
        let viewModel = WeatherHomeViewModel(model: mockModel)
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = 2023
        dateComponents.month = 4
        dateComponents.day = 5
        dateComponents.hour = 12
        dateComponents.minute = 0
        dateComponents.second = 0
        let date = calendar.date(from: dateComponents)!
        XCTAssertFalse(viewModel.isNight(for: date))
        dateComponents.hour = 23
        let nightDate = calendar.date(from: dateComponents)!
        XCTAssertTrue(viewModel.isNight(for: nightDate))
    }

}
