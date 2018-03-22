//
//  SignUpBaseTableViewCell.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 7/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class SignUpBaseTableViewCell: UITableViewCell, SignUpContentableCell {
    var content: SignUpCellContent!
    
    //MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.contentView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.clear
    }
    
    //MARK: Contentable protocol
    func configure() {}
}
