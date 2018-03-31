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
//	private(set) lazy var textField: UITextField = {
//		let width = frame.width - (textLabel!.frame.origin.x + textLabel!.frame.width)
//		let textfield = UITextField(frame: CGRect(x: 0, y: 0, width: width, height: 30))
//		textfield.backgroundColor = .red
//		textfield.translatesAutoresizingMaskIntoConstraints = false
//		textfield.textAlignment = .right
//		return textfield
//	}()
	
	
	override func draw(_ rect: CGRect) {
		super.draw(rect)
	}
}
