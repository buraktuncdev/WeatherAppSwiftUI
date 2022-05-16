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
    @ObservedObject var forecastViewModel: ForecastViewModel = ForecastViewModel(forecastService: ForecastService())
    @State var isLoading = true
    @State var hasServiceError = false
    @State var userCurrentLatitude: Double = 0.0
    @State var userCurrentLongitude: Double = 0.0
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(
                    colors: [Color.yellow.opacity(0.6), Color.purple.opacity(0.4)]),
                               startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 10) {
                    if(!hasServiceError) {
                        if forecastViewModel.isLoaded {
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
                                    HStack {
                                        ForEach(0..<24) { index in
                                            HourlyCardView(hourOfDay: forecastViewModel.hourlyForecastHours[index],
                                                           iconName: forecastViewModel.hourlyIcons[index],
                                                           temperatureHigh: forecastViewModel.hourlyForecastTemperatures[index])
                                        }.padding(.horizontal, 8)
                                    }
                                }
                            }
                            .padding(.bottom)
                        } else {
                            LoadingView(isLoading: $isLoading)
                        }
                    } else {
                        VStack {
                            Text(Constants.ForecastView.serviceErrorText)
                            Spacer()
                        }.alert(isPresented: $hasServiceError) {
                            Alert(title: Text(Constants.ForecastView.serviceErrorTitle), message: Text(forecastViewModel.serviceErrorMessage), dismissButton: .default(Text(Constants.ForecastView.alertActionTitle), action: {
                                forecastViewModel.getForecastData(latitude:  self.userCurrentLatitude, longitude: self.userCurrentLongitude)
                            }))
                        }
                    }
                }
                .onReceive(locationViewModel.$userCurrentLocation) {
                    if let userCurrentLocation = $0 {
                        Logger.shared.log(.success, "user location is: \(userCurrentLocation)")
                        self.userCurrentLatitude = userCurrentLocation.coordinate.latitude
                        self.userCurrentLongitude = userCurrentLocation.coordinate.longitude
                        forecastViewModel.getForecastData(latitude:  self.userCurrentLatitude, longitude: self.userCurrentLongitude)
                    } else {
                        Logger.shared.log(.error, "user location cannot be accessible")
                    }
                }
                .onReceive(forecastViewModel.$isLoaded) {
                    self.isLoading = !$0
                }
                .onReceive(forecastViewModel.$hasError) {
                    self.hasServiceError = $0
                }
            }
        }
    }
}
