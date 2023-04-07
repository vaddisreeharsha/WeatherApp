//
//  MockApiHandler.swift
//  WeatherApp
//
//  Created by SreeHarsha Vaddi on 31/03/23.
//

import Foundation

class MockApiHandler: ApiHandlerDelegate {
    var testUrl: String = "Mock Url"

    var isShowError: Bool
    init(isShowError: Bool = false) {
        self.isShowError = isShowError
    }

    // var myname = "Mock Url"
    ///  Fetching the data from local json file
    /// - Parameters:
    ///   - url: `json` file path
    ///   - completion: It will be eighter data or `ApiError`
    func fetchData(url _: URL, completion: @escaping (Result<Data, ApiError>) -> Void) {
        if isShowError {
            completion(.failure(.badResponse))
            return
        }
        do {
            guard let url = Bundle.main.url(forResource: "WeatherResponse", withExtension: "json") else { return }
            let data = try Data(contentsOf: url)
            completion(.success(data))
        } catch {
            completion(.failure(.noData))
        }
    }
}
