//
//  PushNotificationHandleable.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 25/3/18.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import Foundation
protocol PushNotificationHandleable {
	func handle(content: [String: Any]?, completion: (() -> Void)?)
}
