//
//  CreditCardTextFieldFactory.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 8/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

public struct CreditCardTextFieldFactory {
    enum type: Int {
        case number = 0
        case date
        case cvv
        case name
    }
    
    static func textField(by type: CreditCardTextFieldFactory.type) -> UITextField {
        switch type {
        case .number:
            return createBaseTextfield(with: "credit-card.placeholder.number",
                                       textColor: UIColor.gray)
        case .date:
            return createBaseTextfield(with: "credit-card.placeholder.date",
                                       textColor: UIColor.gray,
                                       textAlignment: .center)
        case .cvv:
            return createBaseTextfield(with: "credit-card.placeholder.cvv",
                                       textColor: UIColor.gray,
                                       textAlignment: .center)
        case .name:
            return createBaseTextfield(with: "credit-card.placeholder.name",
                                       textColor: UIColor.gray,
                                       keyboardType: .default)
        }
    }
}

private extension CreditCardTextFieldFactory {
    //MARK: Private
    static func createBaseTextfield(with placeholder: String,
                             textColor: UIColor,
                             textAlignment: NSTextAlignment = .left,
                             keyboardType: UIKeyboardType = .numberPad) -> UITextField {
        let textfield = UITextField.init()
        textfield.placeholder = Localization.localizableString(by: placeholder)
        textfield.minimumFontSize = 13
        textfield.adjustsFontSizeToFitWidth = true
        textfield.font = UIFont.systemFont(ofSize: 15)
        textfield.textColor = textColor
        textfield.textAlignment = textAlignment
        textfield.keyboardType = keyboardType
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }
}
