//
//  ForecastViewModelTests.swift
//  WeatherAppSwiftUITests
//
//  Created by Burak Tunc on 16.05.22.
//

import XCTest
@testable import WeatherAppSwiftUI

class ForecastViewModelTests: XCTestCase {

    private var sut: ForecastViewModel!
    private var mockForecastService: MockForecastService!
    var bundle: Bundle!
    var bundleURL: URL!

    override func setUpWithError() throws {
        bundle = Bundle(for: ForecastTests.self)
        bundleURL = bundle.url(forResource: "forecast", withExtension: "json")
        
        mockForecastService = MockForecastService()
        sut = ForecastViewModel(forecastService: mockForecastService)
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        sut = nil
        mockForecastService = nil
        try super.tearDownWithError()
    }

    func test_FetchForecasts_HourlyIconsCount_Success() throws {
        // Given
        let data = try Data(contentsOf: bundleURL)
        let response = try JSONDecoder().decode(Forecast.self, from: data)

        mockForecastService.fetchWeatherMockResult = .success(response)

        // When
        sut.setHourlyForecastsViewData(hourlyForecastDataArray: response.hourly.data, timeZone: response.timezone)

        // Then
        XCTAssertEqual(sut.hourlyIcons.count, 49)
    }

    func test_FetchForecasts_HourlyIconsCount_DecodingFailure() throws {
        // Given

        mockForecastService.fetchWeatherMockResult = .failure(.decodingFailure)

        // When
        sut.getForecastData(latitude: 12.1222, longitude: 12.222)

        // Then
        XCTAssertEqual(sut.hourlyIcons.count, 0)
        XCTAssertEqual(sut.hourlyForecastHours.count, 0)
    }

    func test_FetchForecasts_HourlyTemperatures_Success() throws {
        // Given
        let data = try Data(contentsOf: bundleURL)
        let response = try JSONDecoder().decode(Forecast.self, from: data)

        mockForecastService.fetchWeatherMockResult = .success(response)

        // When
        sut.setHourlyForecastsViewData(hourlyForecastDataArray: response.hourly.data, timeZone: response.timezone)

        // Then
        XCTAssertNotNil(sut.hourlyForecastTemperatures)
        XCTAssertEqual(sut.hourlyForecastTemperatures.first, "8º")
        XCTAssertEqual(sut.hourlyForecastTemperatures.last, "7º")
    }

    func test_FetchForecasts_HourlyForecastHours_Success() throws {
        // Given
        let data = try Data(contentsOf: bundleURL)
        let response = try JSONDecoder().decode(Forecast.self, from: data)

        mockForecastService.fetchWeatherMockResult = .success(response)

        // When
        sut.setHourlyForecastsViewData(hourlyForecastDataArray: response.hourly.data, timeZone: response.timezone)

        // Then
        XCTAssertNotNil(sut.hourlyForecastHours)
        XCTAssertEqual(sut.hourlyForecastHours.count, 49)
        XCTAssertEqual(sut.hourlyForecastHours.first, "1:00 AM")
        XCTAssertEqual(sut.hourlyForecastHours.last, "1:00 AM")
    }
}
