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
    
    //MARK: Properties
    var creditCard: HampCreditCard!
    
    //MARK: Life cycle
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        creditNumberLabel.text = "xxxx xxxx xxxx \(creditCard.number.substring(with: 12..<16))"
        
    }

    //MARK: Actions
    @IBAction func checkBoxWasPressed(_ sender: CheckBoxButton) {
        sender.isSelected = !sender.isSelected
    }
}
