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
    
        FabricManager.configure()
        
        let _ = ProvidersManager.sharedInstance
        ProvidersManager.sharedInstance.hampDataManager.printDataBaseFileRoute()
        
//        let book = Booking.init(identifier: "123", userID: "11111", basket: [HiredService.init(service: "Big bag", amount: 3)], price: 31.31, point: "1", pickUpTime: Booking.PickUpTime.afternoon, deliveryLockers: [Locker.init(identifier: "12", number: 31, code: "123", available: true, capacity: Size.M)], pickUpLockers: [Locker.init(identifier: "12", number: 31, code: "123", available: true, capacity: Size.M)])
//        
//        let trasnaction = Transaction.init(identifier: "111", userID: "123333", booking: book, creditCardIdentifier: "222", pickUpDate: "2018-02-14T17:07:52.920", deliveryDate: "2018-02-14T17:07:52.920", created: "true")
//
//        ProvidersManager.sharedInstance.hampDataManager.addData(object: DBTransaction.init(transaction: trasnaction, creditCardNumber: "4555 5555 5555 5555"))
        
        self.showMainViewController()
        
        return true
    }
}

private extension AppDelegate {
    func showMainViewController() {
        var identifier: String
        var storyboardName: String
        
        
//        if let _ = Hamp.Auth.user {
//            identifier = tabBarNavigationViewControllerIdentifier
//            storyboardName = "TabBar"
//        } else {
            identifier = loginViewControllerIdentifier
            storyboardName = "Login"
//        }
        
        let storyboard = UIStoryboard.init(name: storyboardName, bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier)

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = viewController
        self.window?.makeKeyAndVisible()
    }
}

