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
    private var creditCardProvider: CreditCardsProvider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurateNavigationItems ()
        
        creditCardProvider = CreditCardsProvider.init()
        creditCardView.delegate = self
        
        let notCompletedCreditCardContent = createContent(
            action: {},  title: Localization.localizableString(by: "new-credit-card.button.completed-text"),
            identifier: gradientStatesButtonNotCompletedContentIdentifier, isEnabled: false)
        
        let completedCreditCardContent = createContent(
            action: {
                let loadingSpinner = UIActivityIndicatorView.init()
                loadingSpinner.frame.size = CGSize.init(width: 100, height: 100)
                loadingSpinner.center = CGPoint.init(x: self.view.frame.width/2, y: self.view.frame.height/2)
                self.view.addSubview(loadingSpinner)
                loadingSpinner.hidesWhenStopped = true
                loadingSpinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
                loadingSpinner.startAnimating()
                
                self.creditCardProvider.addCreditCard(creditCard: self.creditCardView.getCreditCard(), onSucced: {
                    self.dismiss(animated: true, completion: nil)
                    DispatchQueue.main.async {
                        loadingSpinner.stopAnimating()
                    }
                }, onError: { (errorMessage) in
                    self.dismiss(animated: true, completion: nil)
                    DispatchQueue.main.async {
                        loadingSpinner.stopAnimating()
                    }
                })
        },  title: Localization.localizableString(by: "new-credit-card.button.completed-text"),
            identifier: gradientStatesButtonCompletedContentIdentifier, isEnabled: true)
        
        statesGradientButton.addActionContent(content: notCompletedCreditCardContent, identifier: notCompletedCreditCardContent.identifier)
        statesGradientButton.addActionContent(content: completedCreditCardContent, identifier: completedCreditCardContent.identifier)
        
        statesGradientButton.changeContent(to: gradientStatesButtonNotCompletedContentIdentifier)
     }
    
    @IBAction func buttonWasPressed(_ sender: GradientStatesButton) {
        sender.executeAction()
    }
}

private extension NewCreditCardViewController {
    //MARK: Private
    func configurateNavigationItems () {
        let view = UIView ()
        view.backgroundColor = .red
        let trailingButton = TrailingBarButtonItem(with: view)
       navigationController?.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: nil)
//        navigationController?.addRightBarButtonWhenLargeTitles(rightButton: trailingButton)
    }
    
    func createContent(action: @escaping GradientStatesButtonActionContent.StatesActionBlock, title: String?, identifier: String, isEnabled: Bool) -> GradientStatesButtonActionContent {
        return GradientStatesButtonActionContent.init(identifier: identifier,
                                                      action: action,
                                                      title: title, isEnabled: isEnabled)
    }
}

extension NewCreditCardViewController: CreditCardDelegate {
    func creditCardWasCompleted(_ creditCardUI: CreditCardUIController, creditCard: CreditCard) {
        statesGradientButton.changeContent(to: gradientStatesButtonCompletedContentIdentifier)
        _ = creditCardUI.resignFirstResponder()
    }
    
    func creditCardWasIncompleted(_ creditCardUI: CreditCardUIController, creditCard: CreditCard) {
        statesGradientButton.changeContent(to: gradientStatesButtonNotCompletedContentIdentifier)
    }
}
