//
//  UIColor+Hamp.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 22/7/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

extension UIColor {
	
    static let ligthPink = UIColor(hexString: "#F08086")
    static let darkPink = UIColor(hexString: "#E72F72")
	static let lightGray = UIColor(hexString: "#F2F2F2")
	static let superLightPink = UIColor(hexString: "#FCE4EC")
}

extension UIColor {
    convenience init(hexString:String) {
        let hexString = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) 
        let scanner  = Scanner(string: hexString)
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color:UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
}
