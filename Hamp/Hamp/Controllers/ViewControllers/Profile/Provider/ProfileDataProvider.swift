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
	
	// MARK: - API
	func numberOfSections() -> Int {
		return 3
	}
	
	func numberOfRows() -> Int {
		return 3
	}
	
	func content(at indexPath: IndexPath) -> [ProfileCellContent] {
		assert(false)
	}
	
	
}
