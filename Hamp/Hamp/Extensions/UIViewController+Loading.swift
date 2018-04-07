//
//  UIViewController+Loading.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 7/4/18.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import UIKit

extension UIViewController {
	
	func showLoading() {
		let noti = LoadingUIController()
		UIApplication.topViewController()?.present(noti, animated: false)
	}
	
	func hideLoading() {
		NotificationCenter.default.post(name: NSNotification.Name("dismissLoading"), object: nil)
	}
}
