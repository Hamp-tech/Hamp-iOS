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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addHampPoints()
        mapView.delegate = self
    }
    
    func addHampPoints () {
        guard let currentCoordinate = MapLocation.getCurrentLocation () else {return}
        let hampPoints = StaticPointsProvider().points(on: currentCoordinate, radius: 600)
        
        for hampPoint in hampPoints {
            let artwork = MapArtWork(title: hampPoint.name, locationName: hampPoint.postalCode, discipline: hampPoint.identifier, coordinate: hampPoint.localization)
            mapView.addAnnotation(artwork)
        }
    }
    
    func centerUserLocation () {
        guard let currentCoordinate = MapLocation.getCurrentLocation () else {return}
        let location = CLLocation(latitude: currentCoordinate.latitude, longitude: currentCoordinate.longitude)
        mapView.centerMapOnLocation(location: location)
    }
    
}

extension StoreMapController: MKMapViewDelegate {
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        mapView.showAnnotations(mapView.annotations, animated: true)
    }
}
