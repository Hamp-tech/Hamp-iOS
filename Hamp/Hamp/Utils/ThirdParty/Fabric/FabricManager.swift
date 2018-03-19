//
//  FabricManager.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 7/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation
import Fabric
import Crashlytics
import HampKit

public struct FabricManager {
    static func configure() {
        Fabric.with([Crashlytics.self])
    }
    
    static func logUser() {
        guard let user = Hamp.Auth.user else { return }
        Crashlytics.sharedInstance().setUserName("\(user.name) \(user.surname)")
        Crashlytics.sharedInstance().setUserEmail(user.email)
        Crashlytics.sharedInstance().setUserIdentifier(user.identifier)
    }
}
