//
//  ForecastView.swift
//  WeatherAppSwiftUI
//
//  Created by Burak Tunc on 15.05.22.
//

import SwiftUI

struct ForecastView: View {

    @StateObject private var viewModel = ForecastViewModel()

    var body: some View {
        VStack {
            Text(viewModel.timezone)
            Text("\(viewModel.currentTime)")
        }.onAppear { viewModel.getForecastData() }
    }
}
