//
//  MockApiHandler.swift
//  WeatherApp
//
//  Created by SreeHarsha Vaddi on 31/03/23.
//

import Foundation

class MockApiHandler: ApiHandlerDelegate {
    ///  Fetching the data from local json file
    /// - Parameters:
    ///   - url: `json` file path
    ///   - completion: It will be eighter data or `ApiError`
    func fetchData(url: URL, completion: @escaping (Result<Data, ApiError>) -> Void) {
        do {
            let data = try Data(contentsOf: url)
            completion(.success(data))
        } catch {
            completion(.failure(.noData))
        }
    }
}
