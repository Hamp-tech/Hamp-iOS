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
    
    //MARK: Constructors
    init(placeholder: String, text: String? = nil) {
        self.placeholder = placeholder
        self.text = text
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
        var content: SignUpCellContent!
        switch type {
        case .name:
            content = nameContent()
        case .mail:
            content = mailContent()
        case .phone:
            content = phoneContent()
        case .birthday:
            content = birthdayContent()
        case .password:
            content = passwordContent()
        case .repeatPassword:
            content = repeatPasswordContent()
        default:
            break
        }
        
        return content
    }
    
}

private extension SignUpCellFactory {
    /// Content to name cell
    ///
    /// - Returns: cell content
    static func nameContent() -> SignUpCellContent {
        return SignUpCellContent.init(placeholder: InputType.name.description)
    }
    
    /// Content to mail cell
    ///
    /// - Returns: cell content
    static func mailContent() -> SignUpCellContent {
        return SignUpCellContent.init(placeholder: InputType.mail.description)
    }
    
    /// Content to phone cell
    ///
    /// - Returns: cell content
    static func phoneContent() -> SignUpCellContent {
        return SignUpCellContent.init(placeholder: InputType.phone.description)
    }
    
    /// Content to birthday cell
    ///
    /// - Returns: cell content
    static func birthdayContent() -> SignUpCellContent {
        return SignUpCellContent.init(placeholder: InputType.birthday.description)
    }
    
    /// Content to p cell
    ///
    /// - Returns: cell content
    static func passwordContent() -> SignUpCellContent {
        return SignUpCellContent.init(placeholder: InputType.password.description)
    }
    
    /// Content to p cell
    ///
    /// - Returns: cell content
    static func repeatPasswordContent() -> SignUpCellContent {
        return SignUpCellContent.init(placeholder: InputType.repeatPassword.description)
    }
}

