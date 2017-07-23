//
//  InputTextField.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 23/7/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit
enum InputType {
    case username
    case password
    case unknown
}
class InputTextField: UIView {

    //MARK: Properties
    @IBInspectable var placeholder: String = ""
    var type: InputType = .unknown {
        willSet(newValue) {
            guard let _ = textField else {
                return
            }
            
            setTextFieldType(by: newValue)
        }
    }

    private var textField: HampTextField!

    
    //MARK: Life cycle
    override func draw(_ rect: CGRect) {
        setupTextField()
    }
}
private extension InputTextField {
    /// Add HampTextfield with properly properties
    func setupTextField() {
        textField = HampTextField(frame: bounds)
        textField.delegate = self
        textField.placeholder = placeholder
        setTextFieldType(by: type)
        addSubview(textField)
    }
    
    private func setTextFieldType(by inputType : InputType) {
        switch inputType {
        case .username:
            if #available(iOS 11, *) {
                textField.textContentType = .username
            }
        case .password:
            if #available(iOS 11, *) {
                textField.textContentType = .password
            }
            textField.isSecureTextEntry = true
        default:
            break
        }
    }
}


extension InputTextField : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let baseText = (textField.text ?? "") as NSString
        let completText = baseText.replacingCharacters(in: range, with: string)

        if completText.count > 0 && self.textField.textState == .empty {
            self.textField.textState = .filled
        } else if (completText.count == 0 && self.textField.textState == .filled){
            self.textField.textState = .empty
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
