//
//  ProfileTableViewSection.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 27/3/18.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import Foundation

class ProfileTableViewSection {

	// MARK: - Properties
	let title: String?
	let contents: [ProfileCellContent]
	
	// MARK: - Life cycle
	init(title: String? = nil, contents: [ProfileCellContent]) {
		self.title = title
		self.contents = contents
	}
}
