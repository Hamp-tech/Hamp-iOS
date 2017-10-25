//
//  ProfileTableViewDelegate.swift
//  Hamp
//
//  Created by Aleix Baggerman on 23/10/2017.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class ProfileTableViewDelegate: NSObject, UITableViewDelegate {

    var contentProvider: ProfileTableProvider?
    
    init(provider: ProfileTableProvider) {
        super.init()
        self.contentProvider = provider
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = tableView.cellForRow(at: indexPath)
        
        if cell?.reuseIdentifier == "ProfileTextFieldCell" || cell?.reuseIdentifier == "ProfileDateCell" {
            return 100
        } else  {
            return 70
        }
    }
    
    
    
}
