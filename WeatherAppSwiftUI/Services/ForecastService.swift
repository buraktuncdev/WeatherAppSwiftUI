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
}

public final class ForecastService: ForecastServiceProtocol {

    private let apiManager: APIManager = APIManager()
    private let apiPaths: APIPaths = APIPaths()
    private let apiHelper: APIHelper = APIHelper()

    static let shared: ForecastService = ForecastService()

    func fetchWeatherData(latitude: Double, longitude: Double, completion: @escaping (Result<Forecast, APIError>) -> Void) {
        guard let apiKey = Bundle.main.infoDictionary?["WEATHER_API_KEY"] as? String else {
            Logger.shared.log(.error, "API KEY NOT FOUND")
            return
        }
        let forecastURLString = apiPaths.createForecastURL(apiKey: apiKey, latitude: latitude, longitude: longitude)
        let url = URL(string: forecastURLString)
        guard let url = url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest = apiHelper.setRequestHeaders(request: &urlRequest, headers: ["Content-Type": "application/json"])
        urlRequest = apiHelper.setRequestHttpMethod(request: &urlRequest, httpMethod: .GET)

        apiManager.callAPI(urlRequest: urlRequest, requestBody: nil, expectingReturnType: Forecast.self) { result in
            switch result {
            case .failure(let error):
                Logger.shared.log(.error, error.localizedDescription)
                completion(.failure(error))
            case .success(let forecastData):
                Logger.shared.log(.success, "forecastData")
                completion(.success(forecastData))
            }
        }
    }

}
