//
//  ForecastView.swift
//  WeatherAppSwiftUI
//
//  Created by Burak Tunc on 15.05.22.
//

import SwiftUI
import WeatherAppLogger

struct ForecastView: View {

    @EnvironmentObject var locationViewModel: LocationViewModel
    @ObservedObject var forecastViewModel: ForecastViewModel = ForecastViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(
                    colors: [Color.yellow.opacity(0.6), Color.purple.opacity(0.4)]),
                               startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)

                VStack(spacing: 10) {
                    TodayCardView(cityArea: locationViewModel.userCurrentPlacemark?.subAdministrativeArea ?? "",
                                  todayWeatherAnimation: forecastViewModel.todayWeatherAnimationIcon,
                                  currentTemperature: forecastViewModel.currentTemperature,
                                  currentTime: forecastViewModel.currentTime)
                    Spacer()
                    
                    ExtrasView(windSpeed: forecastViewModel.windSpeed,
                               humidity: forecastViewModel.humidity,
                               visibility: forecastViewModel.visibility)

                    Spacer()
                    VStack {
                        ScrollView(.horizontal, showsIndicators: false) {
                            if(forecastViewModel.isLoaded) {
                                HStack {
                                    ForEach(0..<24) { index in
                                        HourlyCardView(hourOfDay: forecastViewModel.hourlyForecastHours[index],
                                                       iconName: forecastViewModel.hourlyIcons[index],
                                                       temperatureHigh: forecastViewModel.hourlyForecastTemperatures[index])
                                    }.padding(.horizontal, 8)
                                }
                            }
                        }
                    }
                    .padding(.bottom)
                }

            }
            .onReceive(locationViewModel.$userCurrentLocation) {
                if let userCurrentLocation = $0 {
                    Logger.shared.log(.success, "user location is: \(userCurrentLocation)")
                    forecastViewModel.getForecastData(latitude:  userCurrentLocation.coordinate.latitude, longitude: userCurrentLocation.coordinate.longitude)
                } else {
                    Logger.shared.log(.error, "user location cannot be accessible")
                    forecastViewModel.getForecastData(latitude:  59.337239, longitude: 18.062381)
                }
            }
        }
    }
}
