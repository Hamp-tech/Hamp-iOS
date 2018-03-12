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
import Firebase
import FirebaseInstanceID
import FirebaseMessaging

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
		FirebaseApp.configure()
		FabricManager.configure()
		
		Messaging.messaging().delegate = self
		Messaging.messaging().shouldEstablishDirectChannel = true
		
		let _ = ProvidersManager.sharedInstance
		ProvidersManager.sharedInstance.hampDataManager.printDataBaseFileRoute()
		
		showMainViewController()
		
		UNUserNotificationCenter.current().delegate = self
		
		let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
		UNUserNotificationCenter.current().requestAuthorization(
			options: authOptions,
			completionHandler: {_, _ in })
		
		application.registerForRemoteNotifications()
		
		return true
	}
	
	func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
		Logger.d("Registered for remote notifications")
	}
	
	func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
		Logger.d(userInfo)
		completionHandler(.noData)
	}
	
	func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
		print("Failed to register remote notification \(error.localizedDescription)")
		Logger.d(error.localizedDescription, event: .e)
	}
}

extension AppDelegate: UNUserNotificationCenterDelegate, MessagingDelegate {
	// Firebase push
	func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
		print("Push received: \(response.notification.request.content.body)")
		completionHandler()
	}
	
	func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
		Logger.d("Token received: \(fcmToken)")
	}
	
	func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
		Logger.d("Message received: \(remoteMessage.appData)")
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
		
		self.window = UIWindow(frame: UIScreen.main.bounds)
		self.window?.rootViewController = viewController
		self.window?.makeKeyAndVisible()
	}
}

