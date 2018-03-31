//
//  Navigator.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 31/3/18.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import UIKit

struct Navigator {
	
	// MARK: - Properties
	let rootViewController: UIViewController
	
	// MARK: - Life cycle
	init(rootViewController: UIViewController) {
		self.rootViewController = rootViewController
	}
	
	// MARK: - API
	func navigate(navigation: Navigable) {
		navigation.navigate(on: rootViewController)
	}
}
