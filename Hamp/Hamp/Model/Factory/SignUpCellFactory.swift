//
//  SignUpCellFactory.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 31/7/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

public final class SignUpCellContent {
    var color: UIColor = .white
    
    
    init(color: UIColor) {
        self.color = color
    }
}

public struct SignUpCellFactory {
    /// Content types
    static let contentTypes: [InputType] = [.name,
                                            .mail,
                                            .phone,
                                            .birthday,
                                            .password,
                                            .password]
    
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
        return SignUpCellContent.init(color: UIColor.red)
    }
    
    /// Content to mail cell
    ///
    /// - Returns: cell content
    static func mailContent() -> SignUpCellContent {
        return SignUpCellContent.init(color: UIColor.blue)
    }
    
    /// Content to phone cell
    ///
    /// - Returns: cell content
    static func phoneContent() -> SignUpCellContent {
        return SignUpCellContent.init(color: UIColor.green)
    }
    
    /// Content to birthday cell
    ///
    /// - Returns: cell content
    static func birthdayContent() -> SignUpCellContent {
        return SignUpCellContent.init(color: UIColor.brown)
    }
    
    /// Content to p cell
    ///
    /// - Returns: cell content
    static func passwordContent() -> SignUpCellContent {
        return SignUpCellContent.init(color: UIColor.purple)
    }
}

