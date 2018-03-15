//
//  CreditCardTableViewCell.swift
//  Hamp
//
//  Created by Aleix Baggerman on 31/01/2018.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import UIKit
import HampKit

class CreditCardTableViewCell: UITableViewCell {

    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var cardNumberLabel: UILabel!
    
    var creditCard: CreditCard? {
        didSet {
            guard let creditCard = creditCard else {return}
            cardNumberLabel.text = "XXXX XXXX XXXX \(creditCard.number!)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardNumberLabel.textColor = .lightGray
        cardImageView.image = #imageLiteral(resourceName: "credit-card").withRenderingMode(.alwaysOriginal)
        cardImageView.contentMode = .scaleAspectFit
    }
    
}
