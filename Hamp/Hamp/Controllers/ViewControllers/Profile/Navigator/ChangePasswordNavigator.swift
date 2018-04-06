//
//  ChangePasswordNavigator.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 6/4/18.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class ChangePasswordNavigator: Navigable {
	
	// MARK: - Protocol
	func navigate(on rootViewController: UIViewController) {
		let vc = ChangePasswordTableViewController()
		rootViewController.navigationController?.pushViewController(vc, animated: true)
	}
}
