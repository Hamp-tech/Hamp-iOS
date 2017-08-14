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
        },  title: Localization.localizableString(by: "new-credit-card.button.not-completed-text"),
            identifier: gradientStatesButtonNotCompletedContentIdentifier)
        
        let completedCreditCardContent = createContent(
            action: {
            print("bbb")
        },  title: Localization.localizableString(by: "new-credit-card.button.completed-text"),
            identifier: gradientStatesButtonCompletedContentIdentifier)
        
        statesGradientButton.addActionContent(content: notCompletedCreditCardContent,
                                              identifier: notCompletedCreditCardContent.identifier)
        statesGradientButton.addActionContent(content: completedCreditCardContent,
                                              identifier: completedCreditCardContent.identifier)
        statesGradientButton.changeContent(to: gradientStatesButtonNotCompletedContentIdentifier)
     }
    
    @IBAction func buttonWasPressed(_ sender: GradientStatesButton) {
        sender.executeAction()
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
