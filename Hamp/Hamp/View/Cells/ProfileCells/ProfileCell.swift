//
//  ProfileCell.swift
//  Hamp
//
//  Created by Aleix Baggerman on 23/10/2017.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {
    
    // MARK: - Properties
    var content: UserContent?
    var buttonDelegate: ProfileCellButtonDelegate?

    // MARK: - Life cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        selectionStyle = .none
    }

}
