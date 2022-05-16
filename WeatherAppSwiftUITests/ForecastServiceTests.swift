//
//  ForecastServiceTests.swift
//  WeatherAppSwiftUITests
//
//  Created by Burak Tunc on 16.05.22.
//

import XCTest
@testable import WeatherAppSwiftUI

class ForecastServiceTests: XCTestCase {

    var forecastService: ForecastService!

    override func setUp() {
        super.setUp()
        forecastService = ForecastService()
    }

    override class func tearDown() {
        super.tearDown()
    }

    func test_GetWeatherIconName_Success() {
        let rainyIcon = forecastService.getWeatherIcon(iconName: "rain")


        XCTAssertEqual(rainyIcon, "cloud.drizzle.fill")

        let partlyCloudyNightIcon = forecastService.getWeatherIcon(iconName: "partly-cloudy-night")

        XCTAssertNotEqual(partlyCloudyNightIcon, "cloud.drizzle.fill")
        XCTAssertEqual(partlyCloudyNightIcon, "cloud.moon.fill")
    }

    func test_GetWeatherIconName_Failure() {
        let partlyCloudyNightIcon = forecastService.getWeatherIcon(iconName: "partly-cloudy-night")
        let rainyIcon = forecastService.getWeatherIcon(iconName: "rain")

        XCTAssertNotEqual(rainyIcon, "cloud.moon.fill")
        XCTAssertNotEqual(partlyCloudyNightIcon, "cloud.drizzle.fill")
    }

    func test_GetAnimationIconName_Success() {
        let rainyIcon = forecastService.getAnimationName(iconName: "rain")
        let partlyCloudyNightIcon = forecastService.getAnimationName(iconName: "partly-cloudy-night")

        XCTAssertEqual(rainyIcon, "DayRainy")
        XCTAssertEqual(partlyCloudyNightIcon, "DayClearSky")
    }

    func test_GetAnimationIconName_Failure() {
        let rainyIcon = forecastService.getAnimationName(iconName: "rain")
        let partlyCloudyNightIcon = forecastService.getWeatherIcon(iconName: "partly-cloudy-night")

        XCTAssertNotEqual(rainyIcon, "NightClear")
        XCTAssertNotEqual(partlyCloudyNightIcon, "NightClearSky")
    }

    func test_GetTemperatureAsCelcius_Success() {
        let temperatureFromAPI = 73.06 // F
        let strTemp = forecastService.getTemperatureAsCelcius(temp: temperatureFromAPI)

        XCTAssertEqual(strTemp, "23℃")
    }

    func test_GetTemperatureAsCelcius_Failure() {
        let temperatureFromAPI = 48.78 // F
        let strTemp = forecastService.getTemperatureAsCelcius(temp: temperatureFromAPI)

        XCTAssertNotEqual(strTemp, "9")
        XCTAssertNotEqual(strTemp, "9.35")
        XCTAssertEqual(strTemp, "9℃")
    }

    func test_GetTemperatureAsCelcius_WhenTempIsMinus() {
        let temperatureFromAPI = 0 // F
        let strTemp = forecastService.getTemperatureAsCelciusWithoutSymbol(temp: Double(temperatureFromAPI))
        XCTAssertEqual(strTemp, "-18º")
    }

    func test_GetTemperatureAsCelciusWithoutSymbol_Success() {
        let temperatureFromAPI = 73.06 // F
        let strTemp = forecastService.getTemperatureAsCelciusWithoutSymbol(temp: temperatureFromAPI)

        XCTAssertEqual(strTemp, "23º")
    }

    func test_GetTemperatureAsCelciusWithoutSymbol_Failure() {
        let temperatureFromAPI = 48.78 // F
        let strTemp = forecastService.getTemperatureAsCelciusWithoutSymbol(temp: temperatureFromAPI)

        XCTAssertNotEqual(strTemp, "9")
        XCTAssertNotEqual(strTemp, "9.35")
        XCTAssertEqual(strTemp, "9º")
    }

    func test_GetTemperatureAsCelciusWithoutSymbol_WhenTempIsMinus() {
        let temperatureFromAPI = 0 // F
        let strTemp = forecastService.getTemperatureAsCelciusWithoutSymbol(temp: Double(temperatureFromAPI))
        XCTAssertEqual(strTemp, "-18º")
    }
}
