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
        
        FabricManager.configure()
        
        //self.showMainViewController()
        
        return true
    }
}

private extension AppDelegate {
    func showMainViewController() {
        var identifier: String
        var storyboardName: String
        
        if let _ = Hamp.Auth.user() {
            identifier = tabBarNavigationViewControllerIdentifier
            storyboardName = "TabBar"
        } else {
            identifier = loginViewControllerIdentifier
            storyboardName = "Login"
        }
        
        let storyboard = UIStoryboard.init(name: storyboardName, bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = viewController
        self.window?.makeKeyAndVisible()
        
    }
}

