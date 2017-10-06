//
//  CustomMapView.swift
//  Hamp
//
//  Created by Aleix Baggerman on 28/9/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit
import MapKit

class CustomMapView: MKMapView {    
    let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
    let regionRadius: CLLocationDistance = 300
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        self.setRegion(coordinateRegion, animated: true)
    }
}

