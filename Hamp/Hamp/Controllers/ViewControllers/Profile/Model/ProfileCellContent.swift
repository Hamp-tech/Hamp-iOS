//
//  ProfileCellContent.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 27/3/18.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import Foundation

class ProfileCellContent {
	
	// MARK: - Properties
	let title: String
	var value: String
	var isEdited: Bool = false
	
	// MARK: - Life cycle
	init(title: String, value: String) {
		self.title = title
		self.value = value
	}
}
