//
//  UIFont+Helvetica.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 30/7/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

extension UIFont {
    /// HelveticaNeue font
    ///
    /// - Parameter size: size of the font
    /// - Returns: Helvetica neue font with size
    public static func helvetica(withSize size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.regular)
    }
    
    /// Fredoka font
    ///
    /// - Parameter size: size of the font
    /// - Returns: Fredoka font with size
    public static func fredoka(withSize size: CGFloat) -> UIFont {
        return UIFont(name: "FredokaOne-Regular", size: size)!
    }
}
