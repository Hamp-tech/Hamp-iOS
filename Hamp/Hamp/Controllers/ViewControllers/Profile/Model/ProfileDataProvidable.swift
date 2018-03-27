//
//  ProfileDataProvidable.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 27/3/18.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import Foundation

protocol ProfileDataProvidable {
	func numberOfSections() -> Int
	func numberOfRows() -> Int
	func content(at indexPath: IndexPath) -> [ProfileCellContent]
}
