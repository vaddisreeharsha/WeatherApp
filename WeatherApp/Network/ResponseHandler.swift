//
//  ResponseHandler.swift
//  WeatherApp
//
//  Created by SreeHarsha Vaddi on 31/03/23.
//

import Foundation

protocol ResponseHandlerDelegate {
    func fetchDataModel<T: Codable>(type: T.Type, data: Data, completion: (Result<T, ApiError>) -> Void)
}

class ResponseHandler: ResponseHandlerDelegate {
    func fetchDataModel<T>(type: T.Type, data: Data, completion: (Result<T, ApiError>) -> Void) where T: Decodable, T: Encodable {
        let response = try? JSONDecoder().decode(type.self, from: data)
        if let response = response {
            return completion(.success(response))
        } else {
            completion(.failure(.decodingError))
        }
    }
}
