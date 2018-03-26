//
//  TransactionPushNotificationHandler.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 25/3/18.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import HampKit
import RealmSwift

struct TransactionPushNotificationHandler: PushNotificationHandleable {
	
	func handle(content: [String : Any]?, completion: (() -> Void)? = nil) {
		guard let uid = Hamp.Auth.user?.identifier else { return }
		guard let info = content?["info"] as? [String: Any] else { return }
		guard let tid = info["transactionID"] as? String else { return }
		
		Hamp.Transactions.transaction(userID: uid, transactionID: tid) { (response) in
			
            let realm = try! Realm()
            let transaction = realm.objects(DBTransaction.self).filter("identifier = %@", response.data!.identifier!).first
            
            try! realm.write {
                let list = List(elements: response.data!.booking!.deliveryLockers!.map {
                    DBLocker(locker: $0)
                })
                transaction!.booking?.deliveryLockers.append(objectsIn: list)
            }
        
            DispatchQueue.main.async {
				let transaction = response.data!
				let noti = TransactionUINotificationsController(transactionId: transaction.identifier!, header: "Push", subtitle: "Recibido desde la push", lockers: transaction.booking!.deliveryLockers!)
				NotificationsPresenter.shared.enqueu(uinotification: noti)
				completion?()
			}
		}
	}
}
