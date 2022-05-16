//
//  WeatherForecastViewModel.swift
//  WeatherAppSwiftUI
//
//  Created by Burak Tunc on 14.05.22.
//

import Foundation
import SwiftUI
import CoreLocation
import WeatherAppLogger

final class ForecastViewModel: ObservableObject {

    @Published var city: String = "Amsterdam"
    @Published var currentTime: String = ""
    @Published var timezone: String = ""
    @Published var todayWeatherAnimationIcon: String = ""

    @Published var hourlyIcons: [String] = []
    @Published var hourlyForecastTemperatures: [String] = []
    @Published var hourlyForecastHours: [String] = []

    @Published var humidity: String = ""
    @Published var windSpeed: String = ""
    @Published var visibility: String = ""

    @Published var currentTemperature: String = ""
    @Published var isLoaded = false
    @Published var hasError = false
    @Published var serviceErrorMessage: String = ""

    public init() {}

    func getForecastData(latitude: Double, longitude: Double) {
        self.isLoaded = false
        ForecastService.shared.fetchWeatherData(latitude: latitude, longitude: longitude) { [self] result in
            DispatchQueue.main.async {
                self.isLoaded = true
                switch result {
                case .failure(let error):
                    Logger.shared.log(.error, error.localizedDescription)
                    self.hasError = true
                    self.serviceErrorMessage = error.localizedDescription
                case .success(let forecastData):
                    self.hasError = false
                    self.currentTime = DateFormatter.convertUnixToDayAndMonthString(time: forecastData.currently.time, timezone: forecastData.timezone)
                    self.todayWeatherAnimationIcon = self.getAnimationName(iconName: forecastData.currently.icon)
                    self.currentTemperature = self.getTemperatureAsCelcius(temp: forecastData.currently.temperature)
                    self.windSpeed = String(format: "%.1f", forecastData.currently.windSpeed)
                    self.humidity = String(format: "%.0f%%", forecastData.currently.humidity * 100)
                    self.visibility = String(format: "%.1f%km", forecastData.currently.visibility)
                    self.setHourlyForecastsViewData(hourlyForecastDataArray: forecastData.hourly.data, timeZone: forecastData.timezone)
                }
            }
        }
    }

    private func setHourlyForecastsViewData(hourlyForecastDataArray: [HourlyForecast], timeZone: String) {
        hourlyForecastDataArray.forEach { hourlyForecast in
            hourlyIcons.append(getWeatherIcon(iconName:hourlyForecast.icon))
            hourlyForecastTemperatures.append(getTemperatureAsCelciusWithoutSymbol(temp: hourlyForecast.temperature))
            hourlyForecastHours.append(DateFormatter.convertUnixToHour(time: hourlyForecast.time, timezone: timeZone))
        }
    }

    private func getWeatherIcon(iconName: String) -> String {
        switch iconName {
        case Constants.ForecastViewModel.clearDayIconName:
            return Constants.ForecastViewModel.clearDayWeatherIconName
        case Constants.ForecastViewModel.clearNightIconName:
            return Constants.ForecastViewModel.clearNightWeatherIconName
        case Constants.ForecastViewModel.cloudyIconName:
            return Constants.ForecastViewModel.cloudyWeatherIconName
        case Constants.ForecastViewModel.partlyCloudyDayIconName:
            return Constants.ForecastViewModel.partlyCloudyDayWeatherIconName
        case Constants.ForecastViewModel.partlyCloudyNightIconName:
            return Constants.ForecastViewModel.partlyCloudyNightWeatherIconName
        case Constants.ForecastViewModel.rainIconName:
            return Constants.ForecastViewModel.rainWeatherIconName
        case Constants.ForecastViewModel.snowIconName:
            return Constants.ForecastViewModel.snowWeatherIconName
        default:
            return Constants.ForecastViewModel.clearDayWeatherIconName
        }
    }

    private func getAnimationName(iconName: String) -> String {
        switch iconName {
        case Constants.ForecastViewModel.clearDayIconName:
            return Constants.ForecastViewModel.clearDayAnimationName
        case Constants.ForecastViewModel.clearNightIconName:
            return Constants.ForecastViewModel.clearNightAnimationName
        case Constants.ForecastViewModel.cloudyIconName:
            return Constants.ForecastViewModel.cloudyAnimationName
        case Constants.ForecastViewModel.partlyCloudyDayIconName:
            return Constants.ForecastViewModel.cloudyAnimationName
        case Constants.ForecastViewModel.partlyCloudyDayAnimationName:
            return Constants.ForecastViewModel.partlyCloudyNightAnimationName
        case Constants.ForecastViewModel.rainIconName:
            return Constants.ForecastViewModel.rainAnimationName
        case Constants.ForecastViewModel.snowIconName:
            return Constants.ForecastViewModel.snowAnimationName
        default:
            return Constants.ForecastViewModel.clearDayAnimationName
        }
    }

    private func getTemperatureAsCelcius(temp: Double) -> String {
        let strTemp = String(format: "%0.0f", (temp - 32) / 1.8)
        return  "\(strTemp)℃"
    }

    private func getTemperatureAsCelciusWithoutSymbol(temp: Double) -> String {
        return "\(String(format: "%0.0f", (temp - 32) / 1.8))º"
    }
}
