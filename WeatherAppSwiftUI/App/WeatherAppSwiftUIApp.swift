//
//  WeatherAppSwiftUIApp.swift
//  WeatherAppSwiftUI
//
//  Created by Burak Tunc on 14.05.22.
//

import SwiftUI

@main
struct WeatherAppSwiftUIApp: App {

    var body: some Scene {
        WindowGroup {
            ForecastView(viewModel: ForecastViewModel())
        }
    }
}
