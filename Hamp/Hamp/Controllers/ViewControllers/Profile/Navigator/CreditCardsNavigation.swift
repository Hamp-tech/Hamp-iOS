//
//  PaymentMethodsNavigation.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 5/4/18.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class CreditCardsNavigation: Navigable {
	
	// MARK: - Protocol
	func navigate(on rootViewController: UIViewController) {
		let vc = RemoveCreditCardsTableViewController()
		rootViewController.navigationController?.pushViewController(vc, animated: true)
	}
}
