//
//  InputTextField.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 23/7/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit


class InputTextField: UIView {

    //MARK: Properties
    var type: UITextContentType = UITextContentType.name
    @IBInspectable var placeholder: String = ""
    
    private var textField: HampTextField!
    
    //MARK: Life cycle
    override func draw(_ rect: CGRect) {
        textField = HampTextField(frame: rect)
        textField.delegate = self
        textField.placeholder = placeholder
        addSubview(textField)
    }
}

extension InputTextField : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let baseText = (textField.text ?? "") as NSString
        let completText = baseText.replacingCharacters(in: range, with: string)
        
//        self.textField.textState = completText.count == 0 ? .empty : .filled
        if completText.count > 0 && self.textField.textState == .empty {
            self.textField.textState = .filled
        } else if (completText.count == 0 && self.textField.textState == .filled){
            self.textField.textState = .empty
        }
        
        return true
    }
}
