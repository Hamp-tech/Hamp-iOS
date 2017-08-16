//
//  OrderService.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 16/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation

public class OrderService: OrderableService {
    
    //MARK: Properties
    var imageName: String
    var name: String
    var amount: Int
    
    /// Create a new service
    ///
    /// - Parameters:
    ///   - imageName: order image
    ///   - title: title text
    init(imageName: String, name: String) {
        self.imageName = imageName
        self.name = name
        self.amount = 0
    }
}
