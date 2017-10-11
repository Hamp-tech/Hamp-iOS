//
//  StoresListViewController.swift
//  Hamp
//
//  Created by Aleix Baggerman on 6/10/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit
import CoreLocation

class StoresListViewController: PulleyChildViewController {
    
    @IBOutlet weak var searchBarView: HampSearchBarView!
    @IBOutlet weak var tableView: UITableView!
    
    let cellHeight:CGFloat = 100
    var mapUtilities: MapUtilities!
    
    var userCoordinate: CLLocationCoordinate2D? {
        didSet {
            self.filtredHampPoints = hampPoints
            self.searchBarView.initialSearchElements = hampPoints
            
            self.tableView.reloadData()
        }
    }
    
    var hampPoints: [HampPoint] {
        get {
            guard let currentLocation = userCoordinate else {return []}
            let points = StaticPointsProvider ().points(on: currentLocation, radius: 600)
            return points
        }
    }
    
    var filtredHampPoints: [HampPoint]?
    
    override func viewDidLoad() {
        setupMapUtilities ()
        configureTableView ()
        view.backgroundColor = .white
        searchBarView.delegate = self
    }
    
    private func setupMapUtilities () {
        mapUtilities = MapUtilities ()
        mapUtilities.mapDelegate = self
    }
    
    private func configureTableView () {        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        
        let nib = UINib.init(nibName: "StoreTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "StoreTableViewCell")
    }
    
    private func setupPulleyScroll () {
//        let numberOfCells = tableView.numberOfRows(inSection: 0)
//        if numberOfCells * self.cellHeight <= tableView.frame.height {
//
//        }
    }
}

extension StoresListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtredHampPoints?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreTableViewCell") as! StoreTableViewCell
        cell.locationName = filtredHampPoints! [indexPath.row].name
        let distance = mapUtilities.getUserDistanceTo(coordinate: filtredHampPoints! [indexPath.row].localization)
        cell.distance = Float (distance)/1000
        return cell
    }
    
}

extension StoresListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
}

extension StoresListViewController: HampSearchBarDelegate {    
    func searchBarDidUpdateSearchElements(elements: [HampPoint]) {
        filtredHampPoints = elements
        tableView.reloadData()
    }
}

extension StoresListViewController: MapUtilitiesDelegate {
    func getUserLocation(location: CLLocation) {
        self.userCoordinate = location.coordinate
    }
}
