//
//  CreditCardInputTextFieldMaskManager.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 8/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit
import InputMask

protocol CreditCardInputTextDelegate: class {
    func textfieldWasFilled(_ textField: UITextField,
                            type: CreditCardTextFieldFactory.type,
                            text: String)
}

public final class CreditCardInputTextFieldMaskManager: NSObject {
    
    private var masks = [MaskedTextFieldDelegate]()
    private var dict = [UITextField: CreditCardTextFieldFactory.type]()
    weak var delegate: CreditCardInputTextDelegate?
    
    func subscribe(textfield: UITextField,
                   type: CreditCardTextFieldFactory.type,
                   inputMaskType: inputMaskType) {

        var delegate: UITextFieldDelegate
        
        switch inputMaskType {
        case .none:
            delegate = self
        case .format(let format):
            delegate = MaskedTextFieldDelegate.init(format: format)
            (delegate as! MaskedTextFieldDelegate).listener = self
            masks.append(delegate as! MaskedTextFieldDelegate)
        }
        
        textfield.delegate = delegate
        dict[textfield] = type
        
        
    }
}

extension CreditCardInputTextFieldMaskManager {
    enum inputMaskType {
        case none
        case format(String)
    }
}

extension CreditCardInputTextFieldMaskManager: MaskedTextFieldDelegateListener {
    public func textField(_ textField: UITextField, didFillMandatoryCharacters complete: Bool, didExtractValue value: String) {
        if complete {
            delegate?.textfieldWasFilled(textField, type: dict[textField]!, text: value)
        }
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.textfieldWasFilled(textField, type: dict[textField]!, text: textField.text ?? "")
        return true
    }
}
