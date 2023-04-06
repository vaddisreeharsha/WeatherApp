//
//  ViewController.swift
//  WeatherApp
//
//  Created by SreeHarsha Vaddi on 31/03/23.
//

import MapKit
import SDWebImage
import UIKit

class WeatherViewController: UIViewController {
    @IBOutlet var placeLbl: UILabel!

    @IBOutlet var imgIcon: UIImageView!

    @IBOutlet var weatherDescriptionLbl: UILabel!
    @IBOutlet var tempLbl: UILabel!
    @IBOutlet var coordLbl: UILabel!

    @IBOutlet var minTempLbl: UILabel!

    @IBOutlet var maxTempLbl: UILabel!
    @IBOutlet var feelLikeTempLbl: UILabel!
    @IBOutlet var switchToForienHeatsLbl: UILabel!

    @IBOutlet var isForienHeats: UISwitch!
    var resultSearchController: UISearchController!

    var vm: WeatherViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()

        let temp: TempUnit = isForienHeats.isOn ? .fahrenheit : .celsius
        vm = WeatherViewModel(temparatureUnit: temp)
        vm?.delegate = self

        guard
            let lat = UserDefaults.standard.object(forKey: UserDefaultKeys.selectedLat) as? Double,
            let lon = UserDefaults.standard.object(forKey: UserDefaultKeys.selectedLon) as? Double
        else {
            return
        }
        vm?.getWeatherFor(lat: lat, lon: lon)
    }

    @IBAction func onChangeTempUnits(_ sender: UISwitch) {
        vm?.temparatureUnit = sender.isOn ? .fahrenheit : .celsius
        vm?.updateTemparatureUnits(temp: vm?.temparatureUnit ?? .celsius)
    }

    private func setupSearchBar() {
        guard let placeSearchTable = storyboard?.instantiateViewController(withIdentifier: "PlaceSearchTableVC") as? PlaceSearchTableVC else { return }
        placeSearchTable.handlePlaceDelegate = self
        resultSearchController = UISearchController(searchResultsController: placeSearchTable)
        resultSearchController.searchResultsUpdater = placeSearchTable
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        resultSearchController.hidesNavigationBarDuringPresentation = false
        resultSearchController.obscuresBackgroundDuringPresentation = true
        definesPresentationContext = true
    }

    private func bindUI(weather: WeatherReport) {
        placeLbl.text = weather.name + ", " + weather.country
        coordLbl.text = "Coordinates: \(weather.coord.lat), \(weather.coord.lon)"
        tempLbl.text = vm?.getTempWithUnits(tempMessage: "Temparature", tempVal: weather.temp)
        feelLikeTempLbl.text = vm?.getTempWithUnits(tempMessage: "Feel like temparature", tempVal: weather.feelsLike)
        minTempLbl.text = vm?.getTempWithUnits(tempMessage: "Min temparature", tempVal: weather.tempMin)
        maxTempLbl.text = vm?.getTempWithUnits(tempMessage: "Max temparature", tempVal: weather.tempMax)

        imgIcon.sd_setImage(with: weather.icon)
        weatherDescriptionLbl.text = weather.description
    }
}

extension WeatherViewController: WeatherViewModelDelegate {
    func didReceive(weatherReport: WeatherReport?, errorMessage _: String?) {
        guard let weather = weatherReport else {
            // Show error message for weather Api here
            return
        }
        DispatchQueue.main.async {
            self.bindUI(weather: weather)
        }
    }
}

extension WeatherViewController: HandleSearchPlace {
    func selectedPlace(place: MKMapItem) {
        vm?.getWeatherFor(lat: place.placemark.coordinate.latitude,
                          lon: place.placemark.coordinate.longitude)
        UserDefaults.standard.set(place.placemark.coordinate.latitude, forKey: UserDefaultKeys.selectedLat)
        UserDefaults.standard.set(place.placemark.coordinate.longitude, forKey: UserDefaultKeys.selectedLon)
    }
}
