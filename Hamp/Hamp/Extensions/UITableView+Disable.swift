//
//  UITableView+Disable.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 5/4/18.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import UIKit

extension UITableView {
	var footer: Bool {
		get {
			return tableFooterView != nil
		} set(newValue) {
			tableFooterView = newValue ? nil : UIView()
		}
	}
}
