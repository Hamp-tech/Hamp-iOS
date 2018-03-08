//
//  DBPoint.swift
//  Hamp
//
//  Created by Aleix Baggerman on 06/03/2018.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import Foundation
import RealmSwift
import HampKit

class DBPoint: Object {
    
    @objc dynamic var identifier: String = ""
    @objc dynamic var location: DBLocation?
    @objc dynamic var CP: String = ""
    @objc dynamic var address: String = ""
    @objc dynamic var city: String = ""
    
    convenience init (point: Point) {
        self.init()
        self.identifier = point.identifier!
        self.location = DBLocation.init (location: point.location!)
        self.CP = point.CP!
        self.address = point.address!
        self.city = point.city!
    }
    
}
