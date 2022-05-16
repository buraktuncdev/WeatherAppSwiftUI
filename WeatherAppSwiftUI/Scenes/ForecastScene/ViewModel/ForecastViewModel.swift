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

    private let forecastService: ForecastServiceProtocol

    public init(forecastService: ForecastServiceProtocol = ForecastService()) {
        self.forecastService = forecastService
    }

    func getForecastData(latitude: Double, longitude: Double) {
        self.isLoaded = false
        forecastService.fetchWeatherData(latitude: latitude, longitude: longitude) { [self] result in
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
                    self.todayWeatherAnimationIcon = self.forecastService.getAnimationName(iconName: forecastData.currently.icon)
                    self.currentTemperature = self.forecastService.getTemperatureAsCelcius(temp: forecastData.currently.temperature)
                    self.windSpeed = String(format: "%.1f", forecastData.currently.windSpeed)
                    self.humidity = String(format: "%.0f%%", forecastData.currently.humidity * 100)
                    self.visibility = String(format: "%.1f%km", forecastData.currently.visibility)
                    self.setHourlyForecastsViewData(hourlyForecastDataArray: forecastData.hourly.data, timeZone: forecastData.timezone)
                }
            }
        }
    }

    func setHourlyForecastsViewData(hourlyForecastDataArray: [HourlyForecast], timeZone: String) {
        hourlyForecastDataArray.forEach { hourlyForecast in
            hourlyIcons.append(forecastService.getWeatherIcon(iconName:hourlyForecast.icon))
            hourlyForecastTemperatures.append(forecastService.getTemperatureAsCelciusWithoutSymbol(temp: hourlyForecast.temperature))
            hourlyForecastHours.append(DateFormatter.convertUnixToHour(time: hourlyForecast.time, timezone: timeZone))
        }
    }
}
