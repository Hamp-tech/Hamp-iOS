//
//  SignUpCellFactory.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 31/7/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

public final class SignUpCellContent {
    //MARK: Properties
    var placeholder: String?
    var text: String?
    var inputType: InputType!
    var textFieldTextPointer = UnsafeMutablePointer<String>.allocate(capacity: 1)
    
    //MARK: Constructors
    init(placeholder: String,
         text: String? = nil,
         inputType: InputType) {
        textFieldTextPointer.initialize(to: "")
        self.placeholder = placeholder
        self.inputType = inputType
    }
    
    deinit {
        textFieldTextPointer.deallocate(capacity: 1)
    }
}

public struct SignUpCellFactory {
    /// Content types
    static let contentTypes: [InputType] = [.name,
                                            .mail,
                                            .phone,
                                            .birthday,
                                            .password,
                                            .repeatPassword]
    
    /// Factory method to get a cell content by type
    ///
    /// - Parameter type: type of cell
    /// - Returns: content of cell
    static func content(by type: InputType) -> SignUpCellContent {
        var cont: SignUpCellContent = content(inputType: type)
        switch type {
        case .name:
            nameContent(with: &cont)
        case .mail:
            mailContent(with: &cont)
        case .phone:
            phoneContent(with: &cont)
        case .birthday:
            birthdayContent(with: &cont)
        case .password:
            passwordContent(with: &cont)
        case .repeatPassword:
            repeatPasswordContent(with: &cont)
        default:
            break
        }
        return cont
    }
    
}

private extension SignUpCellFactory {
    static func content(inputType: InputType) -> SignUpCellContent {
        return SignUpCellContent.init(placeholder: inputType.description, inputType: inputType)
    }
    
    /// Content to name cell
    ///
    /// - Returns: cell content
    static func nameContent(with content: inout SignUpCellContent) {
    }
    
    /// Content to mail cell
    ///
    /// - Returns: cell content
    static func mailContent(with content: inout SignUpCellContent) {
        
    }
    
    /// Content to phone cell
    ///
    /// - Returns: cell content
    static func phoneContent(with content: inout SignUpCellContent) {
        
    }
    
    /// Content to birthday cell
    ///
    /// - Returns: cell content
    static func birthdayContent(with content: inout SignUpCellContent) {
        
    }
    
    /// Content to password cell
    ///
    /// - Returns: cell content
    static func passwordContent(with content: inout SignUpCellContent) {
        
    }
    
    /// Content to repeatPassword cell
    ///
    /// - Returns: cell content
    static func repeatPasswordContent(with content: inout SignUpCellContent) {
        
    }
}

