//
//  Gender.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 3/4/18.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import Foundation

enum Gender: String {
	case man = "Hombre"
	case woman = "Mujer"
	case unknown = "--"
	
	init(rawValue: String) {
		switch rawValue {
		case "Hombre":
			self = .man
		case "Mujer":
			self = .woman
		default:
			self = .unknown
		}
	}
	
	static let all: [Gender] = {
		return [.man, .woman, .unknown]
	}()
	
	static let rawValues = {
		return all.map{$0.rawValue}
	}()
}

extension Gender {
	func code() -> String {
		let codes: [Gender: String] = [
			.man: "1",
			.woman: "2",
			.unknown: "3"
		]
		
		return codes[self]!
	}
}
