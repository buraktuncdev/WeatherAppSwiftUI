//
//  WeatherForecastService.swift
//  WeatherAppSwiftUI
//
//  Created by Burak Tunc on 14.05.22.
//

import Foundation
import WeatherAppNetwork
import WeatherAppLogger

protocol ForecastServiceProtocol {
    func fetchWeatherData(latitude: Double, longitude: Double, completion: @escaping (Result<Forecast, APIError>) -> Void)
    func getWeatherIcon(iconName: String) -> String
    func getAnimationName(iconName: String) -> String
    func getTemperatureAsCelcius(temp: Double) -> String
    func getTemperatureAsCelciusWithoutSymbol(temp: Double) -> String
}

final class ForecastService: ForecastServiceProtocol {

    private let apiManager: APIManager
    private let apiPaths: APIPaths
    private let apiHelper: APIHelper

    init(apiManager: APIManager = APIManager(),
         apiPaths: APIPaths = APIPaths(),
         apiHelper: APIHelper = APIHelper()) {
        self.apiManager = apiManager
        self.apiPaths = apiPaths
        self.apiHelper = apiHelper
    }

    func fetchWeatherData(latitude: Double, longitude: Double, completion: @escaping (Result<Forecast, APIError>) -> Void) {
        guard let apiKey = Bundle.main.infoDictionary?[Constants.ForecastService.API_KEY] as? String else {
            Logger.shared.log(.error, Constants.ForecastService.apiKeyNotFound)
            return
        }
        let forecastURLString = apiPaths.createForecastURL(apiKey: apiKey, latitude: latitude, longitude: longitude)
        let url = URL(string: forecastURLString)
        guard let url = url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest = apiHelper.setRequestHeaders(request: &urlRequest, headers: Constants.ForecastService.contentTypeHeader)
        urlRequest = apiHelper.setRequestHttpMethod(request: &urlRequest, httpMethod: .GET)
        apiManager.callAPI(urlRequest: urlRequest, requestBody: nil, expectingReturnType: Forecast.self) { result in
            switch result {
            case .failure(let error):
                Logger.shared.log(.error, error.localizedDescription)
                completion(.failure(error))
            case .success(let forecastData):
                Logger.shared.log(.success, Constants.ForecastService.fetchSuccessfullMessage)
                completion(.success(forecastData))
            }
        }
    }

    func getWeatherIcon(iconName: String) -> String {
        switch iconName {
        case Constants.ForecastService.clearDayIconName:
            return Constants.ForecastService.clearDayWeatherIconName
        case Constants.ForecastService.clearNightIconName:
            return Constants.ForecastService.clearNightWeatherIconName
        case Constants.ForecastService.cloudyIconName:
            return Constants.ForecastService.cloudyWeatherIconName
        case Constants.ForecastService.partlyCloudyDayIconName:
            return Constants.ForecastService.partlyCloudyDayWeatherIconName
        case Constants.ForecastService.partlyCloudyNightIconName:
            return Constants.ForecastService.partlyCloudyNightWeatherIconName
        case Constants.ForecastService.rainIconName:
            return Constants.ForecastService.rainWeatherIconName
        case Constants.ForecastService.snowIconName:
            return Constants.ForecastService.snowWeatherIconName
        default:
            return Constants.ForecastService.clearDayWeatherIconName
        }
    }

    func getAnimationName(iconName: String) -> String {
        switch iconName {
        case Constants.ForecastService.clearDayIconName:
            return Constants.ForecastService.clearDayAnimationName
        case Constants.ForecastService.clearNightIconName:
            return Constants.ForecastService.clearNightAnimationName
        case Constants.ForecastService.cloudyIconName:
            return Constants.ForecastService.cloudyAnimationName
        case Constants.ForecastService.partlyCloudyDayIconName:
            return Constants.ForecastService.cloudyAnimationName
        case Constants.ForecastService.partlyCloudyDayAnimationName:
            return Constants.ForecastService.partlyCloudyNightAnimationName
        case Constants.ForecastService.rainIconName:
            return Constants.ForecastService.rainAnimationName
        case Constants.ForecastService.snowIconName:
            return Constants.ForecastService.snowAnimationName
        default:
            return Constants.ForecastService.clearDayAnimationName
        }
    }

    func getTemperatureAsCelcius(temp: Double) -> String {
        let strTemp = String(format: "%0.0f", (temp - 32) / 1.8)
        return  "\(strTemp)???"
    }

    func getTemperatureAsCelciusWithoutSymbol(temp: Double) -> String {
        return "\(String(format: "%0.0f", (temp - 32) / 1.8))??"
    }

}
