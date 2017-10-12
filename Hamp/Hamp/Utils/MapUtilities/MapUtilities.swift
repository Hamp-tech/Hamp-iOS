//
//  MapUtilities.swift
//  Hamp
//
//  Created by Aleix Baggerman on 10/10/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import MapKit

class MapUtilities: NSObject {
    
    var mapDelegate: MapUtilitiesDelegate?
    var locationWasGived = false
    
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        return manager
    } ()
    
    var userLocation: CLLocation?
    
    override init() {
        super.init()
        setupLocationManager()
    }
    
    private func setupLocationManager () {
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    func getUserDistanceTo (coordinate: CLLocationCoordinate2D) -> Double {
        guard let userLocation = userLocation else {return 0}
        let location = CLLocation.init(latitude: coordinate.latitude, longitude: coordinate.longitude)
        return userLocation.distance(from: location)
    }
    
    
}

extension MapUtilities: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first, !locationWasGived {
            mapDelegate?.getUserLocation(location: location)
            userLocation = location
            locationWasGived = true
        }
    }
}
