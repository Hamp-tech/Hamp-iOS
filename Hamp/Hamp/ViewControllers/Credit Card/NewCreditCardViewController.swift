//
//  NewCreditCardViewController.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 7/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit
import HampKit

class NewCreditCardViewController: HampViewController {
    @IBOutlet weak var creditCardView: CreditCardUIComponent!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creditCardView.delegate = self

     }
}

extension NewCreditCardViewController: CreditCardDelegate {
    func creditCardWasCompleted(_ creditCardUI: CreditCardUIComponent, creditCard: HampCreditCard) {
        print(creditCard)
        dismiss(animated: true, completion: nil)
    }
}
