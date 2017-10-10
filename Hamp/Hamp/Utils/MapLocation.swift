//
//  MapLocation.swift
//  Hamp
//
//  Created by Aleix Baggerman on 10/10/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import MapKit

struct MapLocation {
    
    static func getCurrentLocation () -> CLLocationCoordinate2D? {
        let locationManager = CLLocationManager ()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        return locationManager.location?.coordinate
    }
}
