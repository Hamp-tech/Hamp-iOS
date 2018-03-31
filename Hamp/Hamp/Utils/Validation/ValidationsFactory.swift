//
//  ValidationsFactory.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 31/3/18.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import Foundation
import HampKit

class ValidationsFactory {
	enum Option {
		case minimumLetters(num: Int)
		case filled
		case email
		case phone
	}
	
	static func validation(by type: Option,
					toEvaluate: String,
					validatedBlock: @escaping Validation.ValidatedBlock,
					key: String) -> Validation {
		switch type {
		case .minimumLetters(let num):
			return minimumLetters(num: num,
								  toEvaluate: toEvaluate,
								  validatedBlock: validatedBlock,
								  key: key)
		case .filled:
			return minimumLetters(num: 1,
								  toEvaluate: toEvaluate,
								  validatedBlock: validatedBlock,
								  key: key)
		case .email:
			return email(toEvaluate: toEvaluate,
						 validatedBlock: validatedBlock,
						 key: key)
		case .phone:
			return phone(toEvaluate: toEvaluate,
						 validatedBlock: validatedBlock,
						 key: key)
		}
	}
}

private extension ValidationsFactory {
	static func minimumLetters(num: Int,
						toEvaluate: String,
						validatedBlock: @escaping Validation.ValidatedBlock,
						key: String) -> Validation {
		return Validation(with: key,
				   validationBlock: { () -> (Bool) in
					return toEvaluate.count >= num
		}, validatedBlock: validatedBlock)
	}
	
	static func email(toEvaluate: String,
			   validatedBlock: @escaping Validation.ValidatedBlock,
			   key: String) -> Validation {
		let regex = try! Regex(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
		return Validation(with: key,
						  validationBlock: { () -> (Bool) in
							return regex.parse(input: toEvaluate)
		}, validatedBlock: validatedBlock)
	}
	
	static func phone(toEvaluate: String,
			   validatedBlock: @escaping Validation.ValidatedBlock,
			   key: String) -> Validation {
		let regex = try! Regex(pattern: "^[9|6|7][0-9]{8}$")
		return Validation(with: key,
						  validationBlock: { () -> (Bool) in
							return regex.parse(input: toEvaluate)
		}, validatedBlock: validatedBlock)
		
	}
}

