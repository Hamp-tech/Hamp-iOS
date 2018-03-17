//
//  ServicesPaymentCollectionViewCell.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 18/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit
import HampKit

class ServicesPaymentCollectionViewCell: ReusableCollectionViewCell {
    
    //MARK: IB properties
    @IBOutlet weak var creditNumberLabel: UILabel!
    @IBOutlet weak var checkBox: CheckBoxButton!
    
    //MARK: Properties
    var creditCard: CreditCard!
    
    //MARK: Life cycle
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let lastNumbers = creditCard.number!
        creditNumberLabel.text = "xxxx xxxx xxxx \(lastNumbers)"
        checkBox.isUserInteractionEnabled = false
    }

    //MARK: Actions
    @IBAction func checkBoxWasPressed(_ sender: CheckBoxButton) {
        sender.isSelected = !sender.isSelected
    }
}
