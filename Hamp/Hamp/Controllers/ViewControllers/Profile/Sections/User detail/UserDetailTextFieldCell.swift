//
//  UserDetailTextFieldCell.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 31/3/18.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import UIKit
protocol UserDetailTextFieldCellDelegate: class {
	func valueDidChange(on cell: UserDetailTextFieldCell, value: Any?)
}

class UserDetailTextFieldCell: UITableViewCell {

	//MARK: - Properties
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var textField: UITextField!
	weak var delegate: UserDetailTextFieldCellDelegate?
	private var previousText: String?
	
	override var isEditing: Bool {
		didSet {
			textField.isEnabled = isEditing
			if !isEditing {
				textField.resignFirstResponder()
			}
		}
	}
	
	// MARK: - Life cycle
	override func awakeFromNib() {
		super.awakeFromNib()
		textField.isEnabled = false
		textField.delegate = self
	}
	
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		previousText = textField.text
	}
}

extension UserDetailTextFieldCell: UITextFieldDelegate {
	func textFieldDidEndEditing(_ textField: UITextField) {
		guard previousText != textField.text else { return }
		delegate?.valueDidChange(on: self, value: textField.text)
	}
}
