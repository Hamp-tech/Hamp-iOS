//
//  ServicesPaymentCollectionViewCell.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 18/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class ServicesPaymentCollectionViewCell: ReusableCollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func checkBoxWasPressed(_ sender: CheckBoxButton) {
        sender.isSelected = !sender.isSelected
    }
}
