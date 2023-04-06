//
//  Model.swift
//  WeatherApp
//
//  Created by SreeHarsha Vaddi on 31/03/23.
//

import Foundation

// MARK: - WeatherModel

struct WeatherModel: Codable {
    let coord: Coord
    let weather: [Weather]
    let main: Main
    let sys: Sys
    let id: Int
    let name: String

    let cod: Int
}

// MARK: - Coord

struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - Main

struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity, seaLevel, grndLevel: Int?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}

// MARK: - Sys

struct Sys: Codable {
    let country: String
    let sunrise, sunset: Int
}

// MARK: - Weather

struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}
