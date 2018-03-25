//
//  TransactionPushNotificationHandler.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 25/3/18.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import HampKit

struct TransactionPushNotificationHandler: PushNotificationHandleable {
	
	func handle(content: [String : Any]?, completion: (() -> Void)? = nil) {
		guard let uid = Hamp.Auth.user?.identifier else { return }
		guard let info = content?["info"] as? [String: Any] else { return }
		guard let tid = info["transactionID"] as? String else { return }
		
		Hamp.Transactions.transaction(userID: uid, transactionID: tid) { (response) in
			DispatchQueue.main.async {
				let transaction = response.data!
				let noti = TransactionUINotificationsController(transactionId: transaction.identifier!, header: "Push", subtitle: "Recibido desde la push", lockers: transaction.booking!.deliveryLockers!)
				NotificationsPresenter.shared.enqueu(uinotification: noti)
				completion?()
			}
		}
	}
}
