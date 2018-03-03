//
//  ServicesPaymentCollectionViewCell.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 18/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit
import HampKit

protocol CardSelectedDelegate {
    func cardIsSelected (card: CreditCard)
}

class ServicesPaymentCollectionViewCell: ReusableCollectionViewCell {
    
    //MARK: IB properties
    @IBOutlet weak var creditNumberLabel: UILabel!
    @IBOutlet weak var checkBox: CheckBoxButton!
    
    //MARK: Properties
    var creditCard: CreditCard!
    var cardSelectedDelegate: CardSelectedDelegate!
    
    //MARK: Life cycle
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let lastNumbers = creditCard.number?.substring(with: 12..<16) ?? "????"
        creditNumberLabel.text = "xxxx xxxx xxxx \(lastNumbers)"
        
    }

    //MARK: Actions
    @IBAction func checkBoxWasPressed(_ sender: CheckBoxButton) {
        sender.isSelected = !sender.isSelected
        cardSelectedDelegate.cardIsSelected(card: creditCard)
    }
}
