//
//  WeatherQueryComponents.swift
//  WeatherApp
//
//  Created by SreeHarsha Vaddi on 05/04/23.
//

import Foundation

enum TempUnit: String, Codable {
    case celsius = "imperial"
    case fahrenheit = "metric"
}

struct WeatherQueryComponents: Codable {
    let lat: Double
    let lon: Double
    var units: TempUnit
    var appid: String = Constants.apiKey
}

extension WeatherQueryComponents {
    var queryItems: [URLQueryItem] {
        var items = [URLQueryItem]()
        for child in Mirror(reflecting: self).children {
            guard let key = child.label else { continue }
            if key == "units" {
                items.append(URLQueryItem(name: key, value: (child.value as? TempUnit)?.rawValue ?? "imperial"))
                continue
            }
            items.append(URLQueryItem(name: key, value: "\(child.value)"))
        }
        return items
    }
}
