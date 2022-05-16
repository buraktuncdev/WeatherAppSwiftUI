//
//  WeatherAppSwiftUIApp.swift
//  WeatherAppSwiftUI
//
//  Created by Burak Tunc on 14.05.22.
//

import SwiftUI

@main
struct WeatherAppSwiftUIApp: App {
    @StateObject var locationViewModel = LocationViewModel()
    @StateObject var forecastViewModel = ForecastViewModel(forecastService: ForecastService())

    var body: some Scene {
        WindowGroup {
            switch locationViewModel.authStatus {
            case .notDetermined:
                SplashView()
                    .environmentObject(locationViewModel)
            case .restricted:
                LocationErrorView(isActiveSecondView: false,
                                  errorMessage: Constants.WeatherAppSwiftUIApp.locationRestrictedMessage)
            case .denied:
                LocationErrorView(isActiveSecondView: false,
                                  errorMessage: Constants.WeatherAppSwiftUIApp.licationDeniedMessage)
            case .authorizedAlways, .authorizedWhenInUse:
                ForecastView(forecastViewModel: forecastViewModel)
                    .environmentObject(locationViewModel)
            @unknown default:
                fatalError()
            }
        }
    }
}
