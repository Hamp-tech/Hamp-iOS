//
//  UserDetailTextFieldCell.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 31/3/18.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class UserDetailTextFieldCell: UITableViewCell {

	//MARK: - Properties
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var textField: UITextField!
	
	override var isEditing: Bool {
		didSet {
			textField.isEnabled = isEditing
			if !isEditing {
				textField.resignFirstResponder()
			}
		}
	}
	
	// MARK: - Life cycle
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		textField.isEnabled = false
	}
}
