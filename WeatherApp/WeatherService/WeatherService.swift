//
//  WeatherService.swift
//  WeatherApp
//
//  Created by SreeHarsha Vaddi on 31/03/23.
//

import Foundation

class WeatherService {
    let service: NetworkService
    init(service: NetworkService = NetworkService()) {
        self.service = service
        print(service.apiHandler.testUrl)
    }

    func getWeatherDetailsBy(lat: Double, lon: Double, tempUnit: TempUnit = .celsius, completion: @escaping (Result<WeatherModel, ApiError>) -> Void) {
        let weatherComponents = WeatherQueryComponents(lat: lat, lon: lon, units: tempUnit)

        guard var urlComponents = URLComponents(string: Constants.baseUrl) else {
            completion(.failure(ApiError.badUrl))
            return
        }
        urlComponents.queryItems = weatherComponents.queryItems

        guard let url = urlComponents.url else {
            completion(.failure(ApiError.badUrl))
            return
        }
        service.fetchRequest(type: WeatherModel.self, url: url) { result in
            completion(result)
        }
    }
}
