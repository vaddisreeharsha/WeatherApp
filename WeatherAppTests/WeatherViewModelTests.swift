//
//  WeatherViewModelTests.swift
//  WeatherAppTests
//
//  Created by SreeHarsha Vaddi on 07/04/23.
//

@testable import WeatherApp

import XCTest

final class WeatherViewModelTests: XCTestCase {
    override func setUpWithError() throws {
        // viewModel.getWeatherFor(lat: 30, lon: 40)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testForSuccessfullWeatherReport() throws {
        let vm = WeatherViewModel(temparatureUnit: .celsius)
        let weatherService = WeatherService(service: NetworkService(apiHandler: MockApiHandler()))
        vm.weatherService = weatherService
        var weatherResult: WeatherModel?
        var error: ApiError?
        let exp = expectation(description: "SUCCESS")
        weatherService.getWeatherDetailsBy(lat: 30, lon: 40) { result in
            exp.fulfill()
            switch result {
            case let .success(success):
                weatherResult = success
                error = nil
            case let .failure(failure):
                weatherResult = nil
                error = failure
            }
        }
        waitForExpectations(timeout: 3)
        XCTAssertNotNil(weatherResult)
        XCTAssertNil(error)
        XCTAssertEqual(weatherResult?.name, "Sacramento")
        XCTAssertEqual(vm.weatherService.service.apiHandler.testUrl, "Mock Url")
    }

    func testFailedWeatherResponse() throws {
        let weatherService = WeatherService(service: NetworkService(apiHandler: MockApiHandler(isShowError: true)))
        var weatherResult: WeatherModel?
        var error: ApiError?
        let exp = expectation(description: "SUCCESS")
        weatherService.getWeatherDetailsBy(lat: 30, lon: 20) { result in
            switch result {
            case let .success(success):
                weatherResult = success
                error = nil
            case let .failure(failure):
                weatherResult = nil
                error = failure
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 3)
        XCTAssertNotNil(error)
        XCTAssertNil(weatherResult)
        XCTAssertEqual(error, .badResponse)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
