//
//  LaundryService.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 17/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation

class LaundryService: Service {
    
    //MARK: Properties
    var identifier: String
    var amount: Int
    var price: Float
    var name: String
    
    /// Create a new Service
    ///
    /// - Parameter identifier: service identifier
    init(identifier: String, price: Float, name: String, amount: Int = 0) {
        self.identifier = identifier
        self.price = price
        self.name = name
        self.amount = amount
    }
}
