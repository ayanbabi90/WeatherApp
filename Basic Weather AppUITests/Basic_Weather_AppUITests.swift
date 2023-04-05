//
//  Basic_Weather_AppUITests.swift
//  Basic Weather AppUITests
//
//  Created by Ayan Chakraborty on 05/04/23.
//

import XCTest

final class Basic_Weather_AppUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testSearchBar() {
        // Ensure the search bar is displayed
        XCTAssertTrue(app.searchFields["Search for a city"].exists)
        
        // Enter text into the search bar
        app.searchFields["Search for a city"].tap()
        app.searchFields["Search for a city"].typeText("New York")
        
        // Verify that the search text is correct
        XCTAssertEqual(app.searchFields["Search for a city"].value as? String, "New York")
    }
    
    func testWeatherDetails() {
        // Select a city
        app.searchFields["Search for a city"].tap()
        app.searchFields["Search for a city"].typeText("New York")
        app.buttons["search"].tap()
        
        // Wait for the weather details to load
        sleep(2)
        
        // Verify that the weather details are displayed
        XCTAssertTrue(app.staticTexts["New York"].exists)
        XCTAssertTrue(app.staticTexts["72°F"].exists)
        XCTAssertTrue(app.staticTexts["Mostly Cloudy"].exists)
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
