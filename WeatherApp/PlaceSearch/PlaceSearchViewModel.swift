//
//  PlaceSearchViewModel.swift
//  WeatherApp
//
//  Created by SreeHarsha Vaddi on 06/04/23.
//

import Foundation
import MapKit

class PlaceSearchViewModel {
    var matchingItems: [MKMapItem] = []
    var searchResultWorkItem: DispatchWorkItem?

    func searchPlace(searchBarText: String, completion: @escaping () -> Void) {
        searchResultWorkItem?.cancel()
        let workItem = DispatchWorkItem {
            let request = MKLocalSearch.Request()
            request.region = MKCoordinateRegion(.world)
            request.naturalLanguageQuery = searchBarText
            MKLocalSearch(request: request).start { response, _ in
                guard let response = response else {
                    return
                }
                let usMapItems = response.mapItems.filter { $0.placemark.countryCode == "US" }
                self.matchingItems = usMapItems
                completion()
            }
        }
        searchResultWorkItem = workItem
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1), execute: workItem)
    }
}
