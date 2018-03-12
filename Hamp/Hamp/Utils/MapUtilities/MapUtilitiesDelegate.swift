//
//  MapUtilitiesDelegate.swift
//  Hamp
//
//  Created by Aleix Baggerman on 11/10/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation
import CoreLocation

protocol MapUtilitiesDelegate: class {
    func getUserLocation (location: CLLocation)
}
