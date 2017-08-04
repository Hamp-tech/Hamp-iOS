//
//  SignUpCellContent.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 2/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

public final class SignUpCellContent {
    
    //MARK: Properties
    var placeholder: String?
    var text: String?
    var inputType: InputType!
    var validateBlock: Validation.ValidationBlock?
    var keyboardType: UIKeyboardType
    var autocapitalizationType: UITextAutocapitalizationType
    
    //MARK: Constructors
    init(placeholder: String,
         text: String? = nil,
         inputType: InputType,
         keyboardType: UIKeyboardType = .default,
         autocapitalizationType: UITextAutocapitalizationType = .sentences) {
        self.placeholder = placeholder
        self.inputType = inputType
        self.keyboardType = keyboardType
        self.autocapitalizationType = autocapitalizationType
    }
    
}
