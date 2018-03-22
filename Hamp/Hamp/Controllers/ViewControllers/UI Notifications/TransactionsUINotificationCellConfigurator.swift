//
//  TransactionsUINotificationCellConfigurator.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 22/3/18.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import UIKit

struct TransactionsUINotificationCellConfigurator {
	
	func configure(cell: TransactionsUINotificationsTableViewCell, values:(number: String, code: String)) {
		cell.numberLabel.text = values.number
		cell.codeLabel.text = values.code
	}
}
