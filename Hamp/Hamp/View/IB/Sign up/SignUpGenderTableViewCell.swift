//
//  SignUpGenderTableViewCell.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 7/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

@objc protocol GenderCellDelegate: SignUpContentable {
    func manCheckboxWasPressed(_ cell: SignUpGenderTableViewCell)
    func womanCheckboxWasPressed(_ cell: SignUpGenderTableViewCell)
}
class SignUpGenderTableViewCell: SignUpBaseTableViewCell {
    
    //MARK: IB properties
    @IBOutlet private weak var manCheckbox: CheckBoxButton!
    @IBOutlet private weak var womanCheckbox: CheckBoxButton!
    override var canBecomeFirstResponder: Bool { return true }
    
    //MARK: Properties
    weak var genderDelegate: GenderCellDelegate?
    var genderSelected: Gender = .unknown
    
    override func configure() {}
    
    ///MARK: Actions
    @IBAction func manCheckboxWasPressed(_ sender: UIButton) {
        genderSelected = .man
        manCheckbox.isSelected = !manCheckbox.isSelected
        womanCheckbox.isSelected = false
        genderDelegate?.manCheckboxWasPressed(self)
 
    }
    @IBAction func womanCheckboxWasPressed(_ sender: UIButton) {
        genderSelected = .woman
        womanCheckbox.isSelected = !womanCheckbox.isSelected
        manCheckbox.isSelected = false
        genderDelegate?.womanCheckboxWasPressed(self)
    }
}
