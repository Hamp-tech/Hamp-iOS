//
//  UserDetailCellConfigurator.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 31/3/18.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import Foundation

struct UserDetailCellConfigurator {
	
	func configure(cell: UserDetailTextFieldCell, content: ProfileCellContent) {
		cell.titleLabel.text = content.title
		cell.textField.text = content.value
	}
}
