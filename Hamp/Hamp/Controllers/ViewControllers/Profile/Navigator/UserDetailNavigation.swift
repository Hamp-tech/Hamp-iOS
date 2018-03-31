//
//  UserDetailNavigation.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 31/3/18.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class UserDetailNavigation: Navigable {
	// MARK: - Protocol
	
	func navigate(on rootViewController: UIViewController) {
		let vc = UIViewController()
		vc.view.backgroundColor = UIColor.white
		
		rootViewController.navigationController?.pushViewController(vc, animated: true)
	}
	
	
	
}
