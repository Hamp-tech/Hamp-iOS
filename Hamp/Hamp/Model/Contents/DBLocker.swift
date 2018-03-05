//
//  DBLocker.swift
//  Hamp
//
//  Created by Aleix Baggerman on 04/03/2018.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import Foundation
import RealmSwift
import Realm
import HampKit

class DBLocker: Object {
    @objc dynamic var identifier: String = ""
    @objc dynamic var number: Int = 0
    @objc dynamic var code: String = ""
    @objc dynamic var capacity: Int = 0
    
    convenience init (locker: Locker) {
        self.init()
        self.number = locker.number!
        self.code = locker.code!
        self.capacity = locker.capacity!.hashValue
    }
    
    override class func primaryKey () -> String? {
        return "identifier"
    }
    
}
