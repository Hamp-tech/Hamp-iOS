//
//  HistoryTransactionDetailCellConfigurator.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 25/3/18.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import UIKit

struct HistoryTransactionDetailCellConfigurator {
	func configure(cell: UITableViewCell, content: HistoryDetailContent) {
		cell.textLabel?.text = content.title
		cell.detailTextLabel?.text = content.detail
	}
}
