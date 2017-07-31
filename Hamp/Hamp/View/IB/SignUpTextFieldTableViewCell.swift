//
//  SignUpTextFieldTableViewCell.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 31/7/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class SignUpTextFieldTableViewCell: UITableViewCell, SignUpContentableCell, Reusable {
    
    //MARK: Properties
    var content: SignUpCellContent! {
        didSet {
            configure()
        }
    }
    
    //MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /// Public
    func configure() {
        
    }
}
