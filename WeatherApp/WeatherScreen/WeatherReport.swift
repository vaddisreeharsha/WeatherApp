//
//  WeatherReport.swift
//  WeatherApp
//
//  Created by SreeHarsha Vaddi on 07/04/23.
//

import Foundation
import UIKit

struct WeatherReport {
    let id: Int
    let name: String
    let coord: Coord
    let temp, feelsLike, tempMin, tempMax: Double
    let country: String
    let icon: URL?
    let description: String?
}
