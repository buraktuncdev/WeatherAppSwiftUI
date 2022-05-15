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

struct Currently: Codable {
  let time: Int
  let summary: String
  let icon: String
  let temperature: Double
  let humidity: Double
  let windSpeed: Double
  let visibility: Double
}

struct Hourly: Codable {
  let summary: String
  let icon: String
  let data: [HourlyForecast]
}

struct HourlyForecast: Codable {
  let time: Int
  let summary: String
  let icon: String
  let precipType: String?
  let temperature: Double
  let humidity: Double
  let windSpeed: Double
  let visibility: Double
}

struct Daily: Codable {
  let summary: String
  let icon: String
  let data: [DailyForecast]
}

struct DailyForecast: Codable {
  let time: Int
  let summary: String
  let icon: String
  let precipType: String?
  let temperatureHigh: Double
  let temperatureLow: Double
  let humidity: Double
  let windSpeed: Double
  let visibility: Double
}
