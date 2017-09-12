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
        let b1 = HampBooking.init(
            transaction: try! HampTransaction.init(identifier: "1234", userID: "123", cardID: "123", order: HampOrder.init(smallBag: 1, bigBag: 1, curtain: 1, cushion: 0, quilt: 0, sofaCover: 0, blanket: 0)),
            deliveryLocker: try! HampLocker.init(identifier: "1234", booked: false, lockerID: "1", secretKey: "1111"),
            collectionLocker: try! HampLocker.init(identifier: "1234", booked: false, lockerID: "1", secretKey: "2222"))
        
        let b2 = HampBooking.init(
            transaction: try! HampTransaction.init(identifier: "1234", userID: "123", cardID: "123", order: HampOrder.init(smallBag: 1, bigBag: 0, curtain: 0, cushion: 0, quilt: 0, sofaCover: 0, blanket: 0)),
            deliveryLocker: try! HampLocker.init(identifier: "1234", booked: false, lockerID: "1", secretKey: "1111"),
            collectionLocker: try! HampLocker.init(identifier: "1234", booked: false, lockerID: "1", secretKey: "2222"))
        
        let b3 = HampBooking.init(
            transaction: try! HampTransaction.init(identifier: "1234", userID: "123", cardID: "123", order: HampOrder.init(smallBag: 1, bigBag: 0, curtain: 1, cushion: 0, quilt: 0, sofaCover: 0, blanket: 0)),
            deliveryLocker: try! HampLocker.init(identifier: "1234", booked: false, lockerID: "1", secretKey: "1111"),
            collectionLocker: try! HampLocker.init(identifier: "1234", booked: false, lockerID: "1", secretKey: "2222"))
        
        bookings.append(contentsOf: [b1, b2, b3])
    }
    
    
}
