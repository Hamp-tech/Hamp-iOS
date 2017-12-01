//
//  HampUserCache.swift
//  Hamp
//
//  Created by Aleix Baggerman on 30/11/2017.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation
import HampKit

struct HampUserCache {
    private static var user: HampUser!
    
    static func setUser (user: HampUser) {
        self.user = user
    }
    
    static func getUser () -> HampUser {
        return self.user
    }
}
