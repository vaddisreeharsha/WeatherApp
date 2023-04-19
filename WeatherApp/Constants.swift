//
//  Constants.swift
//  WeatherApp
//
//  Created by SreeHarsha Vaddi on 31/03/23.
//

import Foundation

// MARK: - Constants

struct Constants {
    /// Weather Api key
    static let apiKey = "a0b3f067573590f6fe2e65eb6b7fdbae"
    /// Base Url
    static let baseUrl = "https://api.openweathermap.org/data/2.5/weather"
}

// MARK: - Userdefaults keys

/// User defaults keys : Helps to access the key constant
enum UserDefaultKeys {
    /// Selected longitude key
    static let selectedLon = "selectedLon"
    /// Selected latitude key
    static let selectedLat = "selectedLat"
}
