//
//  NetworkService.swift
//  WeatherApp
//
//  Created by SreeHarsha Vaddi on 31/03/23.
//

import Foundation

enum ApiError: Error {
    case badUrl
    case badResponse
    case decodingError
    case noData
}

class Test {
    func fetchData() {
        let obj = NetworkService(apiHandler: MockApiHandler())
        let url = URL(string: "https://stackoverflow.com/questions/64703105/parsing-data-from-local-json-file-swift")
    }
}

class NetworkService {
    let apiHandler: ApiHandlerDelegate
    let responseHandler: ResponseHandlerDelegate
    init(apiHandler: ApiHandlerDelegate = ApiHandler(),
         responseHandler: ResponseHandlerDelegate = ResponseHandler())
    {
        self.apiHandler = apiHandler
        self.responseHandler = responseHandler
    }

    func fetchRequest<T: Codable>(type: T.Type, url: URL, completion: @escaping (Result<T, ApiError>) -> Void) {
        apiHandler.fetchData(url: url) { result in

            switch result {
            case let .success(data):
                self.responseHandler.fetchDataModel(type: type, data: data) { decodableResult in
                    switch decodableResult {
                    case let .success(model):
                        completion(.success(model))
                    case let .failure(error):
                        completion(.failure(error))
                    }
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func downloadImage() {}
}
