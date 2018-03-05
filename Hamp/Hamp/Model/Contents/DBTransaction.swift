//
//  DBTransaction.swift
//  Hamp
//
//  Created by Aleix Baggerman on 04/03/2018.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import Foundation
import RealmSwift
import HampKit
import Realm

class DBTransaction: Object {

    @objc dynamic var identifier:String = ""
    @objc dynamic var creditCardNumber: String = ""
    @objc dynamic var pickUpDate: String = ""
    @objc dynamic var deliveryDate: String = ""
    @objc dynamic var booking: DBBooking?
    
    convenience init (transaction: Transaction, creditCardNumber: String) {
        self.init()
        self.identifier = transaction.identifier!
        self.creditCardNumber = creditCardNumber
        self.pickUpDate = transaction.pickUpDate!
        self.booking = DBBooking.init(booking: transaction.booking!)
    }
    
    override class func primaryKey () -> String? {
        return "identifier"
    }

}

