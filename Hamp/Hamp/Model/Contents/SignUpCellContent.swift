//
//  SignUpCellContent.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 2/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation

public final class SignUpCellContent {
    
    //MARK: Properties
    var placeholder: String?
    var text: String?
    var inputType: InputType!
    var validateBlock: Validation.ValidationBlock?
    
    //MARK: Constructors
    init(placeholder: String,
         text: String? = nil,
         inputType: InputType) {
        self.placeholder = placeholder
        self.inputType = inputType
    }
    
}
