//
//  UserDetailDataProvider.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 31/3/18.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import Foundation

struct UserDetailDataProvider: ProfileDataProvidable {
	
	// MARK: - Properties
	private let sections = UserDetailContentFactory.all()
	
	// MARK: - Protocol
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
	
	func modifiedContents() -> Set<ProfileCellContent> {
		var set = Set<ProfileCellContent>()
		sections.forEach{$0.contents.filter{$0.isEdited}.forEach{set.insert($0)}}
		return set
	}
}
