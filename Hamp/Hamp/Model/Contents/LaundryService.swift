//
//  LaundryService.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 17/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation
import RealmSwift
import Realm
import HampKit

class LaundryService: Object, Service {
    
    //MARK: Properties
    @objc var identifier: String = ""
    @objc dynamic var amount: Int = 0
    @objc var price: Float = 0.0
    @objc dynamic var name: String = ""
    
    /// Create a new Service
    ///
    /// - Parameter identifier: service identifier
    convenience init(identifier: String, price: Float, name: String, amount: Int = 0) {
        self.init()
        self.identifier = identifier
        self.price = price
        self.name = name
        self.amount = amount
    }
    
    convenience init (hiredService: HiredService) {
        self.init()
        self.name = hiredService.service
        self.amount = hiredService.amount
    }   
    
    override static func ignoredProperties() -> [String] {
        return ["identifier", "price"]
    }

}
