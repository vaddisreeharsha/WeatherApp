//
//  PlaceSearchTableVC.swift
//  WeatherApp
//
//  Created by SreeHarsha Vaddi on 05/04/23.
//

import MapKit
import UIKit

class PlaceSearchTableVC: UITableViewController {
    var viewModel: PlaceSearchViewModel?
    var handlePlaceDelegate: HandleSearchPlace?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = PlaceSearchViewModel()
    }

    // MARK: - Table view data source

    override func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return viewModel?.matchingItems.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        guard let mapItem = viewModel?.matchingItems[indexPath.row] else { return cell }
        var config = UIListContentConfiguration.cell()
        config.text = mapItem.placemark.title
        config.secondaryText = mapItem.placemark.locality ?? "" + " " + (mapItem.placemark.country ?? "")
        cell.contentConfiguration = config
        return cell
    }

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let place = viewModel?.matchingItems[indexPath.row] else { return }
        handlePlaceDelegate?.selectedPlace(place: place)
        dismiss(animated: true)
    }
}

extension PlaceSearchTableVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchBarText = searchController.searchBar.text else { return }
        viewModel?.searchPlace(searchBarText: searchBarText, completion: { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
    }
}
