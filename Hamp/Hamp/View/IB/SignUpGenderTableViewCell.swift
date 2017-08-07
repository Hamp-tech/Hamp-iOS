//
//  SignUpGenderTableViewCell.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 7/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class SignUpGenderTableViewCell: SignUpBaseTableViewCell {
    
    @IBOutlet weak var manCheckbox: CheckBoxButton!
    @IBOutlet weak var womanCheckbox: CheckBoxButton!
    
    override func configure() {
        
    }
    ///MARK: Actions
    @IBAction func manCheckboxWasPressed(_ sender: UIButton) {
        manCheckbox.isSelected = !manCheckbox.isSelected
        womanCheckbox.isSelected = false
    }
    @IBAction func womanCheckboxWasPressed(_ sender: UIButton) {
        womanCheckbox.isSelected = !womanCheckbox.isSelected
        manCheckbox.isSelected = false
    }
}
