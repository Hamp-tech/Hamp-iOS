//
//  HampService.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 17/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation

class HampService: Service{
    
    //MARK: Properties
    var identifier: String
    
    /// Create a new Service
    ///
    /// - Parameter identifier: service identifier
    init(identifier: String) {
        self.identifier = identifier
    }
}
