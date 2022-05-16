//
//  DateFormatter+Extension.swift
//  WeatherAppSwiftUI
//
//  Created by Burak Tunc on 15.05.22.
//

import Foundation

extension DateFormatter {

    static func convertUnixToDayAndMonthString(time: Int, timezone: String) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(time))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.DateFormatter.dayAndMonthFormat
        dateFormatter.timeZone = TimeZone(identifier: timezone)
        let localDate = dateFormatter.string(from: date)
        return localDate
    }

    static func convertUnixToHour(time: Int, timezone: String) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(time))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.DateFormatter.hourFormat
        dateFormatter.timeZone = TimeZone(identifier: timezone)
        let localDate = dateFormatter.string(from: date)
        return localDate
    }

}
