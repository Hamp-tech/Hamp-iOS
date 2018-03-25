//
//  RemoteNotificationsHandler.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 12/3/18.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import Firebase
import UserNotifications
import HampKit

class RemoteNotificationsHandler: NSObject {
	
	private var configured = false
	
	// MARK: - Public api
	func configure() {
		guard !configured else { return }
		
		FirebaseApp.configure()
		Messaging.messaging().delegate = self
		configureNotifications()
		configured = true
	}
}

extension RemoteNotificationsHandler {
	func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
		Logger.d("Registered for remote notifications")
	}
	
	func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
		Logger.d(userInfo)
		
		let parsed = parsePushNotification(userInfo: userInfo)
		
		guard let action = parsed.action, let content = parsed.content else {
			completionHandler(.noData)
			return
		}
		
		switch application.applicationState {
		case .active:
			PushNotificationsHandler.executeTask(by: action, content: content) {
				NotificationsPresenter.shared.show()
			}
		default:
			break
		}
		
		
		completionHandler(.newData)
	}
	
	func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
		print("Failed to register remote notification \(error.localizedDescription)")
		Logger.d(error.localizedDescription, event: .e)
	}
}

private extension RemoteNotificationsHandler {
	func configureNotifications() {
		UNUserNotificationCenter.current().delegate = self
		
		let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
		UNUserNotificationCenter.current().requestAuthorization(
			options: authOptions,
			completionHandler: { granted, _ in
				guard granted else { return }
		})
		
		UIApplication.shared.registerForRemoteNotifications()
	}
}

extension RemoteNotificationsHandler: UNUserNotificationCenterDelegate {
	func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
		Logger.d(response.notification.request.content.userInfo)
		
		let parsed = parsePushNotification(userInfo: response.notification.request.content.userInfo)
		
		if let action = parsed.action, let content = parsed.content {
			PushNotificationsHandler.executeTask(by: action, content: content) {
				NotificationsPresenter.shared.show()
			}
		}
		
		
		completionHandler()
	}
	
	private func parsePushNotification(userInfo: [AnyHashable: Any]) -> (action: String?, content: [String: Any]?) {
		guard let aps = userInfo["aps"] as? [String: Any], let action = aps["category"] as? String else {
			return (nil, nil)
		}
		
		guard
			let pushData = userInfo["gcm.notification.data"] as? String,
			let data = pushData.data(using: .utf8),
			let content = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
				return (action, nil)
		}
		
		return (action, content)
	}
}

extension RemoteNotificationsHandler: MessagingDelegate {
	func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
		Logger.d("Token received: \(fcmToken)")
        let user = Hamp.Auth.user
        
        if let u = user, u.tokenFCM != fcmToken {
            u.tokenFCM = fcmToken
            Hamp.Users.update(user: u) { (response) in
                Logger.d(response)
            }
        }
	}
	
	func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
		Logger.d("Message received: \(remoteMessage.appData)")
	}
}

