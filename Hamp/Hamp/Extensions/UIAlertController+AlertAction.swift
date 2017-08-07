//
//  UIAlertController+AlertAction.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 7/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

extension UIAlertAction {
    public enum ActionType {
        case ok
        case cancel
        case destructive(String)
        case custom(String, UIAlertActionStyle)
        
        /// Create action instance for UIAlertController
        ///
        /// - Parameter block: call back function
        /// - Returns: UIAlertAction Instance
        public func action(block: ((String) -> Void)? = nil) -> UIAlertAction {
            var actionStyle: UIAlertActionStyle = .default
            var title = ""
            
            switch self {
            case .ok:
                title = "OK"
            case .cancel:
                actionStyle = .cancel
                title = "Cancel"
            case .destructive(let optionTitle):
                title = optionTitle
                actionStyle = .destructive
            case .custom(let optionTitle, let style):
                title = optionTitle
                actionStyle = style
            }
            
            return UIAlertAction.init(title: title, style: actionStyle, handler: { _ in
                block?(title)
            })
        }
    }
}


extension UIAlertController {
    convenience init(title: String,
                     message: String,
                     actions: UIAlertAction.ActionType?...,
                     style: UIAlertControllerStyle = .alert,
                     block: ((String) -> Void)? = nil) {
        self.init(title: title,
                  message: message,
                  preferredStyle: style)
        
        if actions.isEmpty {
            addAction(UIAlertAction.ActionType.ok.action(block: block))
        } else {
            actions.forEach {
                    addAction(($0?.action(block: block))!)
            }
        }
    }
}
