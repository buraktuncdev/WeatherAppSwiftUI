//
//  MockForecastService.swift
//  WeatherAppSwiftUITests
//
//  Created by Burak Tunc on 16.05.22.
//

@testable import WeatherAppSwiftUI
import WeatherAppNetwork
import Foundation

final class MockForecastService: ForecastServiceProtocol {

    var fetchWeatherMockResult: Result<Forecast, APIError>?

    func fetchWeatherData(latitude: Double, longitude: Double, completion: @escaping (Result<Forecast, APIError>) -> Void) {
        if let result = fetchWeatherMockResult {
            completion(result)
        }
    }


    func getWeatherIcon(iconName: String) -> String {
        switch iconName {
        case Constants.ForecastService.clearDayIconName:
            return Constants.ForecastService.clearDayWeatherIconName
        case Constants.ForecastService.clearNightIconName:
            return Constants.ForecastService.clearNightWeatherIconName
        case Constants.ForecastService.cloudyIconName:
            return Constants.ForecastService.cloudyWeatherIconName
        case Constants.ForecastService.partlyCloudyDayIconName:
            return Constants.ForecastService.partlyCloudyDayWeatherIconName
        case Constants.ForecastService.partlyCloudyNightIconName:
            return Constants.ForecastService.partlyCloudyNightWeatherIconName
        case Constants.ForecastService.rainIconName:
            return Constants.ForecastService.rainWeatherIconName
        case Constants.ForecastService.snowIconName:
            return Constants.ForecastService.snowWeatherIconName
        default:
            return Constants.ForecastService.clearDayWeatherIconName
        }
    }

    func getAnimationName(iconName: String) -> String {
        switch iconName {
        case Constants.ForecastService.clearDayIconName:
            return Constants.ForecastService.clearDayAnimationName
        case Constants.ForecastService.clearNightIconName:
            return Constants.ForecastService.clearNightAnimationName
        case Constants.ForecastService.cloudyIconName:
            return Constants.ForecastService.cloudyAnimationName
        case Constants.ForecastService.partlyCloudyDayIconName:
            return Constants.ForecastService.cloudyAnimationName
        case Constants.ForecastService.partlyCloudyDayAnimationName:
            return Constants.ForecastService.partlyCloudyNightAnimationName
        case Constants.ForecastService.rainIconName:
            return Constants.ForecastService.rainAnimationName
        case Constants.ForecastService.snowIconName:
            return Constants.ForecastService.snowAnimationName
        default:
            return Constants.ForecastService.clearDayAnimationName
        }
    }

    func getTemperatureAsCelcius(temp: Double) -> String {
        let strTemp = String(format: "%0.0f", (temp - 32) / 1.8)
        return  "\(strTemp)℃"
    }

    func getTemperatureAsCelciusWithoutSymbol(temp: Double) -> String {
        return "\(String(format: "%0.0f", (temp - 32) / 1.8))º"
    }
}
