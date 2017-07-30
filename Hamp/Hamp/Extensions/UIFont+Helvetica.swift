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
    /// - Returns: <#return value description#>
    public static func helvetica(withSize size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Medium", size: size)!
    }
    
    /// <#Description#>
    ///
    /// - Parameter size: <#size description#>
    /// - Returns: <#return value description#>
    public static func fredoka(withSize size: CGFloat) -> UIFont {
        return UIFont(name: "FredokaOne-Regular", size: size)!
    }
}
