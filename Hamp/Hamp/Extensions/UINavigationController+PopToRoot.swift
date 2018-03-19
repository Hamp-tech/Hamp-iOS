//
//  UINavigationController+PopToRoot.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 19/3/18.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import UIKit

extension UINavigationController {
	func popToRootViewController(completion: (() -> Void)? = nil) {
		CATransaction.begin()
		CATransaction.setCompletionBlock(completion)
		popToRootViewController(animated: true)
		CATransaction.commit()
	}
}
