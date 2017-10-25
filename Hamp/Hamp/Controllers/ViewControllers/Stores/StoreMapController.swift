//
//  StoreMapController.swift
//  Hamp
//
//  Created by Aleix Baggerman on 9/10/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit
import MapKit

class StoreMapController: PulleyChildViewController {
    
    @IBOutlet weak var mapView: CustomMapView!
    var mapUtilities: MapUtilities!
    
    var userCoordinate: CLLocationCoordinate2D? {
        didSet {
            addHampPoints()
            mapView.showAnnotations(mapView.annotations, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapUtilities = MapUtilities ()
        mapUtilities.mapDelegate = self
        mapView.delegate = self
        mapView.isScrollEnabled = false
    }
    
    func addHampPoints () {
        guard let currentCoordinate = userCoordinate else {return}
        let hampPoints = StaticPointsProvider().points(on: currentCoordinate, radius: 600)
        
        for hampPoint in hampPoints {
            let artwork = MapArtWork(title: hampPoint.name, locationName: hampPoint.postalCode, discipline: hampPoint.identifier, coordinate: hampPoint.localization)
            mapView.addAnnotation(artwork)
        }
    }
    
    func centerUserLocation () {
        guard let currentCoordinate = userCoordinate else {return}
        let location = CLLocation(latitude: currentCoordinate.latitude, longitude: currentCoordinate.longitude)
        mapView.centerMapOnLocation(location: location)
    }
    
}

extension StoreMapController: MKMapViewDelegate {
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        mapView.showAnnotations(mapView.annotations, animated: true)
    }
}

extension StoreMapController: MapUtilitiesDelegate {
    func getUserLocation(location: CLLocation) {
        self.userCoordinate = location.coordinate
    }
}
