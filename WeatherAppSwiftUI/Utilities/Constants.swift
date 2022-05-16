//
//  Constants.swift
//  WeatherAppSwiftUI
//
//  Created by Burak Tunc on 16.05.22.
//

import Foundation

struct Constants {

    // MARK: WeatherAppSwiftUIApp
    struct WeatherAppSwiftUIApp {
        static let locationRestrictedMessage = "Permission of location usage is restricted."
        static let licationDeniedMessage = "Our application does not have location permissions. Please enable it in settings."
    }


    // MARK: DateFormatter
    struct DateFormatter {
        static let dayAndMonthFormat = "E, d MMM"
        static let hourFormat = "h:mm a"
    }

    // MARK: ForecastService
    struct ForecastService {
        static let API_KEY = "WEATHER_API_KEY"
        static let apiKeyNotFound = "API key not found in config"
        static let contentTypeHeader = ["Content-Type": "application/json"]
        static let fetchSuccessfullMessage = "Successfully Fetched Weather Data"
    }

    // MARK: LocationErrorView
    struct LocationErrorView {
        static let iconNameForErrorMessage = "gear"
        static let segueButtonLabel = "Use Application without location"
        static let segueButtonIcon = "cloud.drizzle.fill"
    }

    // MARK: ExtrasView
    struct ExtrasView {
        static let windSpeedIcon = "wind"
        static let windSpeedType = "km/h"
        static let windSpeedTitle = "Wind Speed"
        static let humidityIcon = "humidity"
        static let humidityTitle = "Humidity"
        static let visibilityIcon = "eye"
        static let visibilityTitle = "Visibility"
    }

    struct ForecastViewModel {
        static let clearDayIconName = "clear-day"
        static let clearNightIconName = "clear-night"
        static let cloudyIconName = "cloudy"
        static let partlyCloudyDayIconName = "partly-cloudy-day"
        static let partlyCloudyNightIconName = "partly-cloudy-night"
        static let rainIconName = "rain"
        static let snowIconName = "snow"

        static let clearDayWeatherIconName = "sun.max.fill"
        static let clearNightWeatherIconName = "moon.fill"
        static let cloudyWeatherIconName = "cloud.fill"
        static let partlyCloudyDayWeatherIconName = "cloud.sun.fill"
        static let partlyCloudyNightWeatherIconName = "cloud.moon.fill"
        static let rainWeatherIconName = "cloud.drizzle.fill"
        static let snowWeatherIconName = "cloud.snow.fill"

        static let clearDayAnimationName = "DayClearSky"
        static let clearNightAnimationName = "NightClearSky"
        static let cloudyAnimationName = "DayCloudy"
        static let partlyCloudyDayAnimationName = "DayPartlyCloudy"
        static let partlyCloudyNightAnimationName = "NightPartlyCloudy"
        static let rainAnimationName = "DayRainy"
        static let snowAnimationName = "DaySnow"

        
    }

}
