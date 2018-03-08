//
//  DBLocation.swift
//  Hamp
//
//  Created by Aleix Baggerman on 06/03/2018.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import Foundation
import HampKit
import RealmSwift

class DBLocation: Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
    
    convenience init (location: Location) {
        self.init()
        self.name = location.name!
        self.latitude = location.latitude!
        self.longitude = location.longitude!
    }
}
