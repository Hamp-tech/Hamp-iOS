//
//  NewCreditCardViewController.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 7/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class NewCreditCardViewController: HampViewController, CreditCardDelegate {
    func creditCardWasCompleted(_ creditCard: CreditCardUIComponent, inputTexts: [String]) {
        dismiss(animated: true, completion: nil)
    }
    

    @IBOutlet weak var creditCardView: CreditCardUIComponent!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creditCardView.delegate = self

     }
}
