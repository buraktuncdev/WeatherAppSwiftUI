//
//  ForecastView.swift
//  WeatherAppSwiftUI
//
//  Created by Burak Tunc on 15.05.22.
//

import SwiftUI

struct ForecastView: View {

    @ObservedObject private var viewModel: ForecastViewModel

    public init(viewModel: ForecastViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(
                    colors: [Color.yellow.opacity(0.6), Color.purple.opacity(0.4)]),
                               startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    TodayCardView(todayWeatherIcon: viewModel.todayWeatherIcon,
                                  currentTemperature: viewModel.currentTemperature,
                                  currentTime: viewModel.currentTime)
                    Spacer()
                    
                    ExtrasView()

                    Spacer()
                    VStack {
                        ScrollView(.horizontal, showsIndicators: false) {
                            if(viewModel.isLoaded) {
                                HStack {
                                    ForEach(0..<24) { index in
                                        HourlyCardView(hourOfDay: viewModel.hourlyForecastHours[index],
                                                      iconName: viewModel.hourlyIcons[index],
                                                      temperatureHigh: viewModel.hourlyForecastTemperatures[index])
                                    }.padding(.horizontal, 8)
                                }
                            }
                        }
                    }
                    .padding(.bottom)
                }

            }
            .onAppear { viewModel.getForecastData() }
        }

    }
}
