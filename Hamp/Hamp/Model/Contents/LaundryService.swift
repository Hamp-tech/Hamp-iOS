//
//  LaundryService.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 17/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation

class LaundryService: Service{
    
    //MARK: Properties
    var identifier: String
    var amount: Int
    
    /// Create a new Service
    ///
    /// - Parameter identifier: service identifier
    init(identifier: String) {
        self.identifier = identifier
        amount = 0
    }
}
