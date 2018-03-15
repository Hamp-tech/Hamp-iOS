//
//  DBBooking.swift
//  Hamp
//
//  Created by Aleix Baggerman on 04/03/2018.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import Foundation
import RealmSwift
import Realm
import HampKit

class DBBooking: Object {
    @objc dynamic var price: Float = 0.0
    @objc dynamic var point: DBPoint?
    @objc dynamic var pickUpTime: Int = 0
    var services = List<LaundryService>()
    var deliveryLockers = List <DBLocker>()
    var pickUpLockers = List <DBLocker>()

    convenience init (booking: Booking) {
        self.init()
        self.price = booking.price!
        self.point = DBPoint.init(point: booking.point!)
        self.pickUpTime = booking.pickUpTime!.hashValue
        self.pickUpLockers = convertLockersToList(lockers: booking.pickUpLockers!)
        self.deliveryLockers = convertLockersToList(lockers: booking.deliveryLockers)
        convertServicesToList(hiredServices: booking.basket!)
        
    }

    private func convertLockersToList (lockers: [Locker]?) -> List<DBLocker> {
        guard let lockers = lockers else {return List<DBLocker> ()}
        
        let dbLockers = List<DBLocker>()
        for locker in lockers {
            dbLockers.append(DBLocker.init(locker: locker))
        }
        return dbLockers
    }
    
    private func convertServicesToList (hiredServices: [HiredService]) {
        for service in hiredServices {
            services.append(LaundryService.init(hiredService: service))
        }
    }
}
