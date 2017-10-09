//
//  HampPointsProvider.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 9/10/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation
import MapKit

protocol HampPointsProvider {
    func points(on coordinate: CLLocationCoordinate2D, radius: Float) -> [HampPoint]
    func point(identifier: String) -> HampPoint?
}
