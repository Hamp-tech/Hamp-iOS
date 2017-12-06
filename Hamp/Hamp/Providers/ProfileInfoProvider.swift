//
//  ProfileInfoProvider.swift
//  Hamp
//
//  Created by Aleix Baggerman on 20/10/2017.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation
import HampKit

struct ProfileInfoProvider: ProfileTableProvider {
    
    private var content: [[UserContent]]!
    
    init<T: UIViewController>(user: HampUser, parent: T) where T: GMDatePickerDelegate {
        content = ProfileInfoFactory.createProfileInfo(user: user, parent: parent)
    }
    
    func numberOfSections() -> Int {
        return content.count
    }
    
    func numberOfItems(at section: Int) -> Int {
        return content[section].count
    }
    
    func content(at indexPath: IndexPath) -> UserContent? {
        return content [indexPath.section][indexPath.row]
    }
}
