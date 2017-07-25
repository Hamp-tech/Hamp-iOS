//
//  AppDelegate.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 29/6/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit
import HampKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        Hamp.environtment = try? HampEnvirontmentsProvider.productionEnvirontment()
        try? Hamp.connect()
        
        return true
    }
}

