//
//  WeatherForecastTest.swift
//  WeatherAppSwiftUITests
//
//  Created by Burak Tunc on 15.05.22.
//

import XCTest
@testable import WeatherAppSwiftUI

class WeatherForecastTests: XCTestCase {

    func testWeatherForecaseModel_WhenDataProvided_TimezoneShouldMatch() throws {
        let bundle = Bundle(for: WeatherForecastTests.self)
        guard let url = bundle.url(forResource: "forecast", withExtension: "json") else {
            XCTFail("forecast.json not found")
            return
        }

        let data = try Data(contentsOf: url)
        let response = try JSONDecoder().decode(Forecast.self, from: data)

        XCTAssertEqual(response.timezone, "Europe/Stockholm")
        XCTAssertNotEqual(response.timezone, "Europe/Berlin")
    }

    func testWeatherForecaseModel_WhenDataProvided_CurrentSummaryShouldMatch() throws {
        let bundle = Bundle(for: WeatherForecastTests.self)
        guard let url = bundle.url(forResource: "forecast", withExtension: "json") else {
            XCTFail("forecast.json not found")
            return
        }

        let data = try Data(contentsOf: url)
        let response = try JSONDecoder().decode(Forecast.self, from: data)

        XCTAssertEqual(response.currently.summary, "Clear")
        XCTAssertNotEqual(response.timezone, "Cloudy")
    }

}
