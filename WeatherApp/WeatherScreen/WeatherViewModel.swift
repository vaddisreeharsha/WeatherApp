//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by SreeHarsha Vaddi on 06/04/23.
//

import Foundation
import MapKit

/// Handle serch place protocal : helps to get the selected protocal 
protocol HandleSearchPlace {
    func selectedPlace(place: MKMapItem)
}

protocol WeatherViewModelDelegate {
    func didReceive(weatherReport: WeatherReport?, errorMessage: String?)
}

class WeatherViewModel {
    var weatherService = WeatherService()
    var temparatureUnit: TempUnit

    var delegate: WeatherViewModelDelegate?

    init(temparatureUnit: TempUnit) {
        self.temparatureUnit = temparatureUnit
    }

    func getWeatherFor(lat: Double, lon: Double) {
        weatherService.getWeatherDetailsBy(lat: lat, lon: lon, tempUnit: temparatureUnit) { result in
            switch result {
            case let .success(weatherResult):
                print(weatherResult)
                let weatherReport = self.getWeatherReport(from: weatherResult)
                self.delegate?.didReceive(weatherReport: weatherReport, errorMessage: nil)
            case let .failure(failure):
                print(failure)
                self.delegate?.didReceive(weatherReport: nil, errorMessage: failure.localizedDescription)
            }
        }
    }

    private func getWeatherReport(from weather: WeatherModel) -> WeatherReport {
        let mainWeather = weather.main
        let weatherItem = weather.weather.first
        let imgUrl = weather != nil ? URL(string: "https://openweathermap.org/img/wn/\(weatherItem!.icon)@2x.png") : nil
        return WeatherReport(
            id: weather.id,
            name: weather.name,
            coord: weather.coord,
            temp: mainWeather.temp,
            feelsLike: mainWeather.feelsLike,
            tempMin: mainWeather.tempMin,
            tempMax: mainWeather.tempMax,
            country: weather.sys.country,
            icon: imgUrl,
            description: weatherItem?.description
        )
    }

    func getTempWithUnits(tempMessage: String, tempVal: Double) -> String {
        let tempUnitsStr = temparatureUnit == TempUnit.celsius ? " °C" : " °F"

        return "\(tempMessage) : \(tempVal)\(tempUnitsStr)"
    }

    func updateTemparatureUnits(temp: TempUnit) {
        temparatureUnit = temp
        guard
            let lat = UserDefaults.standard.object(forKey: UserDefaultKeys.selectedLat) as? Double,
            let lon = UserDefaults.standard.object(forKey: UserDefaultKeys.selectedLon) as? Double
        else {
            return
        }
        getWeatherFor(lat: lat, lon: lon)
    }
}
