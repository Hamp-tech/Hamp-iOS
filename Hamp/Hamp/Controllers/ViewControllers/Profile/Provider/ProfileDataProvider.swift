//
//  ProfileDataProvider.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 27/3/18.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import Foundation

class ProfileDataProvider: ProfileDataProvidable {
	
	// MARK: - Properties
	private let sections = ProfileSectionFactory.all()
	
	// MARK: - API
	func numberOfSections() -> Int {
		return sections.count
	}
	
	func numberOfRows(at section: Int) -> Int {
		return sections[section].contents.count
	}
	
	func title(at section: Int) -> String? {
		return sections[section].title
	}
	
	func content(at indexPath: IndexPath) -> ProfileCellContent {
		return sections[indexPath.section].contents[indexPath.row]
	}
}
