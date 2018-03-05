//
//  OrderHistoryCellContent.swift
//  Hamp
//
//  Created by Aleix Baggerman on 05/03/2018.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import UIKit
import HampKit

class OrderHistoryCellContent: OrderHistoryContent {
    var identifier: String!
    var title: String?
    var images: [UIImage]?
    var lockers: [DBLocker]?
    var services: [LaundryService]?
    var time: Booking.PickUpTime?
    var creditCardNumber: String?
    
    init (identifier: String, title: String? = nil,
          images: [UIImage]? = nil,
          lockers: [DBLocker]? = nil,
          services: [LaundryService]? = nil,
          time: Booking.PickUpTime? = nil,
          creditCardNumber: String? = nil) {
        self.identifier = identifier
        self.title = title
        self.images = images
        self.lockers = lockers
        self.services = services
        self.time = time
        self.creditCardNumber = creditCardNumber
    }
    
}
