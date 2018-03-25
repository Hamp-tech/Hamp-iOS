//
//  MKMapView+Location.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 25/3/18.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import MapKit

extension MKMapView {
	func center(on location: CLLocation, distance: CLLocationDistance) {
		let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, distance * 2.0, distance * 2.0)
		self.setRegion(coordinateRegion, animated: true)
	}
}
