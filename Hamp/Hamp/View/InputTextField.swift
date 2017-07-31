//
//  InputTextField.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 23/7/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

public enum InputType: CustomStringConvertible {
    case name
    case username
    case mail
    case password
    case phone
    case birthday
    case gender
    case unknown
    
    public var description: String {
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
    weak var delegate: InputTextFieldDelegate? = nil
    var placeholder: String?
    var type: InputType = .unknown {
        willSet(newValue) {
            guard let _ = textField else { return }
            setTextFieldType(by: newValue)
        }
    }
    private var _text: String?
    var text: String? {
        get {
            if let t = textField { return t.text }
            return _text
        } set {
            if let t = textField { t.text = newValue }
            _text = newValue
            isEmpty = newValue == nil
        }
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
        let textFieldText = text
        textField = HampTextField(frame: bounds)
        textField.delegate = self
        textField.placeholder = placeholder
        textField.text = textFieldText
        setTextFieldType(by: type)
        addSubview(textField)
    }
    
    /// Set textfield type
    ///
    /// - Parameter inputType: textfield 
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
    
    /// Text state by textfield text
    ///
    /// - Parameter text: text to compare
    /// - Returns: text state based on text string and textfield state
    private func textState(by text: String) -> HampTextField.TextState {
        var tfState: HampTextField.TextState = .empty
        
        if text.count > 0 && self.textField.textState == .empty {
            tfState = .filled
        } else if (text.count == 0 && self.textField.textState == .filled){
            tfState = .empty
        }
        
        return tfState
    }
}


extension InputTextField : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let baseText = (textField.text ?? "") as NSString
        let completText = baseText.replacingCharacters(in: range, with: string)

        self.textField.textState = textState(by: completText)
        
        isEmpty = completText.count == 0
        delegate?.textField?(self, replacementString: completText)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.textfieldPressReturn?(self)
        return true
    }
}
