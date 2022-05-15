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

    @Published var city: String = "San Francisco"
    @Published var currentTime: String = ""
    @Published var timezone: String = ""
    @Published var todayWeatherIcon: String = ""

    @Published var hourlyIcons: [String] = []
    @Published var hourlyForecastTemperatures: [String] = []
    @Published var hourlyForecastHours: [String] = []

    @Published var humidity: String = ""
    @Published var windSpeed: String = ""
    @Published var visibility: String = ""

    @Published var currentTemperature: String = ""
    @Published var isLoaded = false

    public init() {}

    // TODO: AlertItem, Loading View

    func getForecastData(latitude: Double, longitude: Double) {
        self.isLoaded = false
        ForecastService.shared.fetchWeatherData(latitude: latitude, longitude: longitude) { [self] result in
            DispatchQueue.main.async {
                self.isLoaded = true
                switch result {
                case .failure(let error):
                    Logger.shared.log(.error, error.localizedDescription)
                    // TODO: ALERT
                case .success(let forecastData):
                    self.currentTime = DateFormatter.convertUnixToDayAndMonthString(time: forecastData.currently.time, timezone: forecastData.timezone)
                    self.todayWeatherIcon = self.getWeatherIcon(iconName: forecastData.currently.icon)
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
        case "clear-day":
            return "sun.max.fill"
        case "clear-night":
            return "moon.fill"
        case "cloudy":
            return "cloud.fill"
        case "partly-cloudy-day":
            return "cloud.sun.fill"
        case "partly-cloudy-night":
            return "cloud.moon.fill"
        case "rain":
            return "cloud.drizzle.fill"
        case "snow":
            return "cloud.snow.fill"
        default:
            return "sun.max.fill"
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
