//
//  StaticPointsProvider.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 9/10/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation
import CoreLocation

struct StaticPointsProvider: HampPointsProvider {
    
    // MARK: - Properties
    private let points = [
        HampPoint.init(identifier: "123", name: "Lavanda laundry", localization: CLLocationCoordinate2DMake(41.21738999999999, 1.528220000000033), postalCode: "43700"),
        HampPoint.init(identifier: "124", name: "Esglesia", localization: CLLocationCoordinate2DMake(41.2200907, 1.5351918999999725), postalCode: "43700"),
        HampPoint.init(identifier: "125", name: "Mercat", localization: CLLocationCoordinate2DMake(41.2196489, 1.5360524999999825), postalCode: "43700"),
    ]
    
    // MARK: - API
    func points(on coordinate: CLLocationCoordinate2D, radius: Float) -> [HampPoint] {
        return points
    }
    
    func point(identifier: String) -> HampPoint? {
        return points.filter{ $0.identifier == identifier}.first
    }
}
