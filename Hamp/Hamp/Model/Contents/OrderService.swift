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
    var service: Service
    var imageName: String
    
    /// Create a new service
    ///
    /// - Parameters:
    ///   - imageName: order image
    ///   - title: title text
    init(service: Service, imageName: String) {
        self.service = service
        self.imageName = imageName
    }
}

