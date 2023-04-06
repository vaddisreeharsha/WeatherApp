//
//  Constants.swift
//  WeatherApp
//
//  Created by SreeHarsha Vaddi on 31/03/23.
//

import Foundation

struct Constants {
    static let apiKey = "a0b3f067573590f6fe2e65eb6b7fdbae"
    static let baseUrl = "https://api.openweathermap.org/data/2.5/weather"
}

enum UserDefaultKeys {
    static let selectedPlace = "selectedPlace"
    static let selectedLon = "selectedLon"
    static let selectedLat = "selectedLat"
}
