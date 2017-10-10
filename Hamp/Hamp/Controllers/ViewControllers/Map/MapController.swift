//
//  MapController.swift
//  Hamp
//
//  Created by Aleix Baggerman on 28/9/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit
import MapKit

class MapController: PulleyChildViewController {
    
    @IBOutlet weak var mapView: CustomMapView!
    
    override func viewDidLoad() {
        loadMapLocation (location: CLLocation(latitude: 41.215590, longitude: 1.527245), pinTitle: "HampOffice", locationName: "El Vendrell", discipline: "Office")

        setupMapView ()
    }
    
    fileprivate func setupMapView () {
        mapView.isScrollEnabled = false        
    }
    
    func loadMapLocation (location: CLLocation, pinTitle: String, locationName: String, discipline: String) {
        mapView.centerMapOnLocation(location: location)
        let artwork = MapArtWork(title: pinTitle, locationName: locationName, discipline: discipline, coordinate: location.coordinate)
        mapView.addAnnotation(artwork)
    }
    
    
}
