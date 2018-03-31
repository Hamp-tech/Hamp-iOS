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
	let navigation: Navigable?
	var value: String?
	var isEdited: Bool = false
	var jsonKey: String?
	var validation: ValidationsFactory.Option?
	
	// MARK: - Life cycle
	init(title: String,
		 value: String? = nil,
		 navigation: Navigable? = nil,
		 jsonKey: String? = nil,
		 validation: ValidationsFactory.Option? = nil) {
		self.title = title
		self.value = value
		self.navigation = navigation
		self.jsonKey = jsonKey
		self.validation = validation
	}
}

extension ProfileCellContent: Hashable {
	var hashValue: Int {
		return title.hashValue
	}
	
	static func ==(lhs: ProfileCellContent, rhs: ProfileCellContent) -> Bool {
		return lhs.title == rhs.title && lhs.value == rhs.value
	}
}
