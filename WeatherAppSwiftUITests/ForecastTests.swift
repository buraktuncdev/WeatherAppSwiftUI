//
//  WeatherForecastTest.swift
//  WeatherAppSwiftUITests
//
//  Created by Burak Tunc on 15.05.22.
//

import XCTest
@testable import WeatherAppSwiftUI

class ForecastTests: XCTestCase {

    var bundle: Bundle!
    var bundleURL: URL!

    override func setUp() {
        bundle = Bundle(for: ForecastTests.self)
        bundleURL = bundle.url(forResource: "forecast", withExtension: "json")
    }

    func test_Forecast_WhenDataProvided_TimezoneShouldMatch() throws {
        guard let bundleURL = bundleURL else {
            XCTFail("data file not found")
            return
        }
        let data = try Data(contentsOf: bundleURL)
        let response = try JSONDecoder().decode(Forecast.self, from: data)

        XCTAssertEqual(response.timezone, "Europe/Stockholm")
        XCTAssertNotEqual(response.timezone, "Europe/Berlin")
    }

    func test_Forecast_WhenDataProvided_CurrentSummaryShouldMatch() throws {
        guard let bundleURL = bundleURL else {
            XCTFail("data file not found")
            return
        }

        let data = try Data(contentsOf: bundleURL)
        let response = try JSONDecoder().decode(Forecast.self, from: data)

        XCTAssertEqual(response.currently.summary, "Clear")
        XCTAssertNotEqual(response.timezone, "Cloudy")
    }

    func test_Forecast_WhenDataProvided_HourlyDataShouldMatch() throws {
        guard let bundleURL = bundleURL else {
            XCTFail("data file not found")
            return
        }

        let data = try Data(contentsOf: bundleURL)
        let response = try JSONDecoder().decode(Forecast.self, from: data)

        let expectedCount = 49
        XCTAssertEqual(response.hourly.data.count, expectedCount)
    }

}
