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
    
    func textFieldAreNotFilled(_ textField: UITextField,
                               type: CreditCardTextFieldFactory.type)
}

public final class CreditCardInputTextFieldMaskManager: NSObject {
    
    private var maskTypes = [UITextField: InputMaskType]()
    private var masks = [UITextField: UITextFieldDelegate]()
    private var dict = [UITextField: CreditCardTextFieldFactory.type]()
    weak var delegate: CreditCardInputTextDelegate?
    
    func subscribe(textfield: UITextField,
                   type: CreditCardTextFieldFactory.type,
                   inputMaskType: InputMaskType) {

        var delegate: UITextFieldDelegate
        
        switch inputMaskType {
        case .none:
            delegate = self
        case .format(let format):
            delegate = MaskedTextFieldDelegate.init(format: format)
            (delegate as! MaskedTextFieldDelegate).listener = self
        }
        
        textfield.delegate = delegate
        maskTypes[textfield] = inputMaskType
        masks[textfield] = delegate
        dict[textfield] = type
        
        
    }
}

extension CreditCardInputTextFieldMaskManager {
    enum InputMaskType {
        case none
        case format(String)
    }
}

extension CreditCardInputTextFieldMaskManager: MaskedTextFieldDelegateListener {
    public func textField(_ textField: UITextField, didFillMandatoryCharacters complete: Bool, didExtractValue value: String) {
        if complete {
            delegate?.textfieldWasFilled(textField, type: dict[textField]!, text: value)
        } else {
            delegate?.textFieldAreNotFilled(textField, type: dict[textField]!)
        }
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard case .none = maskTypes[textField]! else { return true }
        
        let baseText = (textField.text ?? "") as NSString
        let completeText = baseText.replacingCharacters(in: range, with: string)
        let complete = completeText.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count > 0
        if !complete {
            delegate?.textFieldAreNotFilled(textField, type: dict[textField]!)
        }
        
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.textfieldWasFilled(textField, type: dict[textField]!, text: textField.text ?? "")
        return true
    }
}
