//
//  UserDetailCellValidator.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 31/3/18.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import Foundation

struct UserDetailCellValidator {
	
	// MARK: - Properties
	private let validationManager = ValidationManager()
	
	// MARK: - API
	func validation(cell: UserDetailTextFieldCell, content: ProfileCellContent) {
		guard let v = content.validation else { return }
		validationManager.add(by: ValidationsFactory.validation(by: v, toEvaluate: cell.textField.text!, validatedBlock: { (key, valid) in
			cell.titleLabel.textColor = valid ? .black : .red
		}, key: content.jsonKey!))
	}
	
	func validate(onSuccess: () -> Void, onError: () -> Void) {
		validationManager.validate(onSuccess: onSuccess, onError: onError)
	}
}
