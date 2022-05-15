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
        let forecastURLString = apiPaths.createForecastURL(apiKey: Constants.apiKey, latitude: 59.337239, longitude: 18.062381)
//        let forecastURLString = apiPaths.createForecastURL(apiKey: Constants.apiKey, latitude: 38.16, longitude: 31.59)
        let url = URL(string: forecastURLString)
        guard let url = url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest = apiHelper.setRequestHeaders(request: &urlRequest, headers: ["Content-Type": "application/json"])
        urlRequest = apiHelper.setRequestHttpMethod(request: &urlRequest, httpMethod: .GET)

        apiManager.callAPI(urlRequest: urlRequest, requestBody: nil, expectingReturnType: Forecast.self) { result in // TODO: can be removed expecting return type
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
