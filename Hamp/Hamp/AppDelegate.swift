//
//  AppDelegate.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 29/6/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit
import HampKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	private let remoteNotificationsHandler = RemoteNotificationsHandler()
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
		remoteNotificationsHandler.configure()
		FabricManager.configure()
		
		let _ = ProvidersManager.sharedInstance
		ProvidersManager.sharedInstance.hampDataManager.printDataBaseFileRoute()
		
		showMainViewController()
		
		return true
	}
	
	func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
		remoteNotificationsHandler.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
	}
	
	func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
		remoteNotificationsHandler.application(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler)
	}
	
	func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
		remoteNotificationsHandler.application(application, didFailToRegisterForRemoteNotificationsWithError: error)
	}
}

private extension AppDelegate {
	
	func showMainViewController() {
		var identifier: String
		var storyboardName: String
		
		
		if let _ = Hamp.Auth.user {
			identifier = tabBarNavigationViewControllerIdentifier
			storyboardName = "TabBar"
		} else {
			identifier = loginViewControllerIdentifier
			storyboardName = "Login"
		}
		
		let storyboard = UIStoryboard.init(name: storyboardName, bundle: Bundle.main)
		let viewController = storyboard.instantiateViewController(withIdentifier: identifier)
		let noti = TransactionUINotificationsController(nibName: nil, bundle: nil)
		
		
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = viewController
		window?.makeKeyAndVisible()
		
//		NotificationsPresenter.shared.present(uinotification: noti)
	}
}

