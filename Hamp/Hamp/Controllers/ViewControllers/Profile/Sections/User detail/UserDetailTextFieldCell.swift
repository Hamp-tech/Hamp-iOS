//
//  UserDetailTextFieldCell.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 31/3/18.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import UIKit
protocol UserDetailTextFieldCellDelegate: class {
	func becameFirstResponder(on cell: UserDetailTextFieldCell)
//	func resignedFirstResponder(on cell: UserDetailTextFieldCell)
	func shouldBecomeFirstResponder(on cell: UserDetailTextFieldCell) -> Bool
	func needsToBeRespondered(on cell: UserDetailTextFieldCell)
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
				_ = resignFirstResponder()
			}
		}
	}
	

	// MARK: - Life cycle
	override func awakeFromNib() {
		super.awakeFromNib()
		textField.delegate = self
	}
	
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		previousText = textField.text
	}
	
	// MARK: - Customizing
	override func becomeFirstResponder() -> Bool {
		textField.becomeFirstResponder()
		return super.becomeFirstResponder()
	}
	
	override func resignFirstResponder() -> Bool {
		if textField.isFirstResponder {
			textFieldDidEndEditing(textField)
			textField.resignFirstResponder()
		}
		return super.resignFirstResponder()
	}
}

extension UserDetailTextFieldCell: UITextFieldDelegate {
	func textFieldDidBeginEditing(_ textField: UITextField) {
		delegate?.becameFirstResponder(on: self)
	}
	
	func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
		delegate?.needsToBeRespondered(on: self)
		return delegate?.shouldBecomeFirstResponder(on: self) ?? true
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
//		self.delegate?.resignedFirstResponder(on: self)
		
		guard previousText != textField.text else { return }
		delegate?.valueDidChange(on: self, value: textField.text)
	}
	
	
}
