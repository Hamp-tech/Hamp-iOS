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
    @IBOutlet weak var creditCardView: CreditCardUIController!
    
    @IBOutlet weak var statesGradientButton: GradientStatesButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creditCardView.delegate = self
        let notCompletedCreditCardContent = createContent(
            action: {
            print("aaa")
        },  title: "Later",
            identifier: gradientStatesButtonNotCompletedContentIdentifier)
        
        let completedCreditCardContent = createContent(
            action: {
            print("aaa")
        },  title: "OK",
            identifier: gradientStatesButtonCompletedContentIdentifier)
        
        statesGradientButton.addActionContent(content: notCompletedCreditCardContent, identifier: notCompletedCreditCardContent.identifier)
        statesGradientButton.addActionContent(content: completedCreditCardContent, identifier: completedCreditCardContent.identifier)
     }
    
}

private extension NewCreditCardViewController {
    //MARK: Private
    func createContent(action: @escaping GradientStatesButtonActionContent.StatesActionBlock, title: String?, identifier: String) -> GradientStatesButtonActionContent {
        return GradientStatesButtonActionContent.init(identifier: identifier,
                                                      action: action,
                                                      title: title)
    }
}

extension NewCreditCardViewController: CreditCardDelegate {
    func creditCardWasCompleted(_ creditCardUI: CreditCardUIController, creditCard: HampCreditCard) {
        statesGradientButton.changeContent(to: gradientStatesButtonCompletedContentIdentifier)
        _ = creditCardUI.resignFirstResponder()
    }
    
    func creditCardWasIncompleted(_ creditCardUI: CreditCardUIController, creditCard: HampCreditCard) {
        statesGradientButton.changeContent(to: gradientStatesButtonNotCompletedContentIdentifier)
    }
}
