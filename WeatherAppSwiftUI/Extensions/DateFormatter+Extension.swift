//
//  DateFormatter+Extension.swift
//  WeatherAppSwiftUI
//
//  Created by Burak Tunc on 15.05.22.
//

import Foundation

extension DateFormatter {

    static func convertUnixToDateString(time: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(time))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }

    static func convertUnixToDayAndMonthString(time: Int, timezone: String) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(time))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM"
        dateFormatter.timeZone = TimeZone(identifier: timezone)
        let localDate = dateFormatter.string(from: date)
        return localDate
    }

    static func convertUnixToDay(time: Int, timezone: String) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(time))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        dateFormatter.timeZone = TimeZone(identifier: timezone)
        let localDate = dateFormatter.string(from: date)
        return localDate
    }

    static func convertUnixToHour(time: Int, timezone: String) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(time))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.timeZone = TimeZone(identifier: timezone)
        let localDate = dateFormatter.string(from: date)
        return localDate
    }

}
