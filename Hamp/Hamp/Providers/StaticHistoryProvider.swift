//
//  StaticHistoryProvider.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 11/9/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation
import HampKit

class StaticHistoryProvider: HistoryProvider {
    
    // MARK: - Properties
    var bookings: [HampBooking] = []
    
    // MARK: - API
    func download() {
        let b11 = try! HampBooking.init(transaction: HampTransaction.init(cardID: "1234", order: HampOrder.init(identifier: "1234", userID: "ID", basket: [], price: "31.44", pickUpTime: "1994-11-07T13:15:30Z", deliveryLocker: HampLocker.init(identifier: "1234", number: 12, key: 12, available: true, capacity: "A lot"), pickUpLocker: HampLocker.init(identifier: "1234", number: 2, key: 2, available: false, capacity: "asda"), location: HampLocation.init(latitude: 31, longitude: 13, name: "El VEndrell")), date: "1994-11-07T13:15:30Z"), deliveryLocker: HampLocker.init(identifier: "asd", number: 2, key: 2, available: true, capacity: "asd"), collectionLocker: HampLocker.init(identifier: "asd", number: 1, key: 2, available: true, capacity: "asf"))

        bookings.append(contentsOf: [b11, b11])
    
    }
    
    
}
