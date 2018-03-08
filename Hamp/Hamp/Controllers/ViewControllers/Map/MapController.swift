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
    var point: DBPoint! {
        didSet {
            guard let location = point.location else {return}
            loadMapLocation (location: CLLocation(latitude: location.latitude, longitude: location.longitude), pinTitle: location.name, locationName: point.city, discipline: point.address)
        }
    }
    
    override func viewDidLoad() {
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
