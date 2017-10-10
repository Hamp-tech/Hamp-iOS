//
//  StoresListViewController.swift
//  Hamp
//
//  Created by Aleix Baggerman on 6/10/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class StoresListViewController: PulleyChildViewController {
    
    @IBOutlet weak var searchBarView: HampSearchBarView!
    @IBOutlet weak var tableView: UITableView!
    
    var hampPoints: [HampPoint] {
        get {
            guard let currentLocation = MapLocation.getCurrentLocation () else {return []}
            let points = StaticPointsProvider ().points(on: currentLocation, radius: 600)
            return points
        }
    }
    
    var filtredHampPoints: [HampPoint]!
    
    override func viewDidLoad() {
        self.filtredHampPoints = hampPoints
        configureTableView ()
        view.backgroundColor = .red
        searchBarView.delegate = self
    }
    
    private func configureTableView () {        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .yellow
        
        let nib = UINib.init(nibName: "StoreTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "StoreTableViewCell")
    }
}

extension StoresListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtredHampPoints.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreTableViewCell") as! StoreTableViewCell
        cell.locationNameLabel.text = filtredHampPoints [indexPath.row].name
        return cell
    }
    
}

extension StoresListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension StoresListViewController: HampSearchBarDelegate {
    func searchBarSetInitialElements() -> [HampPoint] {
        return hampPoints
    }
    
    func searchBarDidUpdateSearchElements(elements: [HampPoint]) {
        filtredHampPoints = elements
        tableView.reloadData()
    }
}
