//
//  ProfileInfoProvider.swift
//  Hamp
//
//  Created by Aleix Baggerman on 20/10/2017.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation
import HampKit

class ProfileInfoProvider: ProfileTableProvider {
    
    private var content: [[UserContent]]!
    private var isCellEnabled:Bool = false
    
    init<T: UIViewController>(parent: T) where T: GMDatePickerDelegate {
        content = ProfileInfoFactory.createProfileInfo(user: Hamp.Auth.user!, parent: parent)
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
    
    func setCellsEnabled (enabled: Bool) {
        isCellEnabled = enabled
    }
    
    func user() -> User {
        let name = content(at: IndexPath.init(row: 0, section: 0))?.textFieldText ?? ""
        let surname = content(at: IndexPath.init(row: 1, section: 0))?.textFieldText ?? ""
        let email = content(at: IndexPath.init(row: 2, section: 0))?.textFieldText ?? ""
        let phone = content(at: IndexPath.init(row: 3, section: 0))?.textFieldText ?? ""
        let birthday = content(at: IndexPath.init(row: 4, section: 0))?.textFieldText ?? ""
        let gender = (content(at: IndexPath.init(row: 5, section: 0))?.firstOption ?? .leftOption) == .leftOption ? "M":"F"
        
        let userID = Hamp.Auth.user!.identifier
        
        return User.init(identifier: userID, name: name, surname: surname, email: email, password: nil, phone: phone, birthday: birthday, gender: gender)
    }
    
    func areCellsEnabled () -> Bool {
        return isCellEnabled
    }
    
}
