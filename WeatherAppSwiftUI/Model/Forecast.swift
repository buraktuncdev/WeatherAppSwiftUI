//
//  WeatherForecast.swift
//  WeatherAppSwiftUI
//
//  Created by Burak Tunc on 14.05.22.
//

import Foundation

struct Forecast: Codable {
  let latitude: Double
  let longitude: Double
  let timezone: String
  let currently: Currently
  let hourly: Hourly
  let daily: Daily
  let offset: Int
}

extension Forecast {
  struct Currently: Codable {
    let time: Int
    let summary: String
    let icon: String
    let temperature: Double
    let humidity: Double
    let pressure: Double
    let windSpeed: Double
    let visibility: Int
  }
}

extension Forecast {
  struct Hourly: Codable {
    let summary: String
    let icon: String
    let data: [Data]
  }
}

extension Forecast.Hourly {
  struct Data: Codable {
    let time: Int
    let summary: String
    let icon: String
    let temperature: Double
    let humidity: Double
    let pressure: Double
    let windSpeed: Double
    let precipType: String?
  }
}

extension Forecast {
  struct Daily: Codable {
    let summary: String
    let icon: String
    let data: [Data]
  }
}

extension Forecast.Daily {
  struct Data: Codable {
    let time: Int
    let summary: String
    let icon: String
    let sunriseTime: Date
    let sunsetTime: Date
    let precipType: String?
    let temperatureHigh: Double
    let temperatureHighTime: Date
    let temperatureLow: Double
    let temperatureLowTime: Date
    let humidity: Double
    let pressure: Double
    let windSpeed: Double
    let temperatureMin: Double
    let temperatureMinTime: Date
    let temperatureMax: Double
    let temperatureMaxTime: Date
  }
}
