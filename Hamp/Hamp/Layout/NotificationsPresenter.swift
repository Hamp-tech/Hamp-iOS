//
//  NotificationsPresenter.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 21/3/18.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class NotificationsPresenter {
	
	static let shared = NotificationsPresenter()
	
	// MARK: - Properties
	private var notificationsEnqueued: [UINotificable] = []
	private var topViewController: UIViewController? {
		get {
			return UIApplication.topViewController()
		}
	}
	private var viewControllerActive: UINotificationsContainerViewController?
	
	func present(uinotification: UINotificable) {
		guard let topViewController = topViewController else { return }
		let vc = UINotificationsContainerViewController(notification: uinotification)
		
		topViewController.present(vc, animated: false)
		viewControllerActive = vc
	}
	
	
	func enqueu(uinotification: UINotificable) {
		notificationsEnqueued.append(uinotification)
	}
	
	func show() {
		let first = notificationsEnqueued.first
		guard let noti = first else { return }
		present(uinotification: noti)
		notificationsEnqueued.removeFirst()
	}
}
