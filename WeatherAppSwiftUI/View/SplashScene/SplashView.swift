//
//  SplashView.swift
//  WeatherAppSwiftUI
//
//  Created by Burak Tunc on 15.05.22.
//

import SwiftUI
import CoreLocation

struct SplashView: View {
    @EnvironmentObject var locationViewModel: LocationViewModel

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(
                colors: [Color.yellow.opacity(0.6), Color.purple.opacity(0.4)]),
                           startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
        }.onAppear {
            locationViewModel.requestPermission()
        }
    }
}
