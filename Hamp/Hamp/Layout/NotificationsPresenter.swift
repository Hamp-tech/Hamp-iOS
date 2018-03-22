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
	private var topViewController: UIViewController? {
		get {
			return UIApplication.topViewController()
		}
	}
	
	func present(uinotification: UINotificable) {
		guard let topViewController = topViewController else { return }
		let vc = UINotificationsContainerViewController(notification: uinotification)
		
		topViewController.present(vc, animated: false)
		
	}
}
