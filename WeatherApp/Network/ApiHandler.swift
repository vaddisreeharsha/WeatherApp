//
//  ApiHandler.swift
//  WeatherApp
//
//  Created by SreeHarsha Vaddi on 31/03/23.
//

import Foundation

protocol ApiHandlerDelegate {
    func fetchData(url: URL, completion: @escaping (Result<Data, ApiError>) -> Void)
}

class ApiHandler: ApiHandlerDelegate {
    func fetchData(url: URL, completion: @escaping (Result<Data, ApiError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            guard let response = response as? HTTPURLResponse, (200 ... 299).contains(response.statusCode) else {
                return completion(.failure(.badResponse))
            }
            print(response.url)
            completion(.success(data))

        }.resume()
    }

    func downloadImage() {
        // URLSession.shared.dow
    }
}
