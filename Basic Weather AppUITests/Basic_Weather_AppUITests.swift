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
        let searchButtonHome = app.buttons["searchButtonHome"]
        searchButtonHome.tap()
        searchButtonHome.tap()
        XCTAssertTrue(searchButtonHome.exists)
        XCTAssertTrue(searchButtonHome.waitForExistence(timeout: 5.0))
        
        let searchField = app.textFields["searchTextField"]
        XCTAssertTrue(searchField.waitForExistence(timeout: 5.0))
        
        searchField.tap()
        searchField.typeText("Durgapur")
        XCTAssertEqual(searchField.value as? String, "Durgapur")
        app.buttons["searchButton"].tap()
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
