//
//  UIView+ParentViewController.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 18/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UINavigationController {
                return viewController.topViewController
            } else if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
