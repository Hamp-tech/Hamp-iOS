//
//  InputTextField.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 23/7/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit


enum InputType: CustomStringConvertible {
    case name
    case username
    case mail
    case password
    case phone
    case birthday
    case gender
    case unknown
    
    var description: String {
        var text: String
        switch self {
        case .name:
            text = "name"
        case .username:
            text = "username"
        case .mail:
            text = "mail"
        case .password:
            text = "password"
        case .phone:
            text = "phone"
        case .birthday:
            text = "birthday"
        case .gender:
            text = "gender"
        case .unknown:
            text = "unknown"
        }
        return text
    }
}

@objc protocol InputTextFieldDelegate {
    @objc optional func textField(_ textField: InputTextField, replacementString string: String)
    @objc optional func textfieldPressReturn(_ textfield : InputTextField)
}

class InputTextField: UIView {

    //MARK: Private Properties
    private var textField: HampTextField!
    
    //MARK: Public properties
    var placeholder: String?
    weak var delegate: InputTextFieldDelegate? = nil
    var type: InputType = .unknown {
        willSet(newValue) {
            guard let _ = textField else { return }
            setTextFieldType(by: newValue)
        }
    }
    var text: String? {
        get { return textField.text }
        set { textField.text = newValue }
    }
    private(set) public var isEmpty: Bool = true

    
    //MARK: Life cycle
    override func draw(_ rect: CGRect) {
        setupTextField()
    }
    
    override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        return textField.resignFirstResponder()
    }
    
    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        return textField.becomeFirstResponder()
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
        
        isEmpty = completText.count == 0
        delegate?.textField?(self, replacementString: completText)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.textfieldPressReturn?(self)
        return true
    }
}
