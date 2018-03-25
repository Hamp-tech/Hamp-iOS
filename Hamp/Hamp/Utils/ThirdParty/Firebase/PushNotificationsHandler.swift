//
//  PushNotificationsHandler.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 25/3/18.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import Foundation

struct PushNotificationsHandler {
	
	// MARK: - Properties
	static let tasks: [String: PushNotificationHandleable] = ["com.Hamp.Hamp.push.downloadTransaction": TransactionPushNotificationHandler()]
	
	static func executeTask(by identifier: String, content: [String: Any]? = nil, completion: (() -> Void)? = nil) {
		let handler = tasks[identifier]
		handler?.handle(content: content, completion: completion)
	}
	
}
