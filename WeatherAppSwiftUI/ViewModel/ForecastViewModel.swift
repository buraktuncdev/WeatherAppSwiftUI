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

    @Published var timezone: String = ""
    @Published var currentTime: String = "0"
    @Published var isLoading = false
    // TODO: AlertItem, Loading View

    func getForecastData() {
        isLoading = true

        ForecastService.shared.fetchWeatherData(latitude: 59.337239, longitude: 18.062381) { [self] result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .failure(let error):
                    Logger.shared.log(.error, error.localizedDescription)
                    // TODO: ALERT
                case .success(let forecastData):
                    Logger.shared.log(.success, forecastData.timezone)
                    self.timezone = forecastData.timezone
                    self.currentTime = DateFormatter.convertDateFromUnix(time: forecastData.currently.time)
                }
            }
        }
    }


}
