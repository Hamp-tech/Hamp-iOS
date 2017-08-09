//
//  SignInToolbar.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 23/7/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class SignInToolbar: UIToolbar {
    
    //MARK: Life cycle
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupBorderTop()
    }
}

private extension SignInToolbar {
    func setupBorderTop() {
        let borderLayer = CALayer()
        borderLayer.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 1)
        borderLayer.backgroundColor = UIColor.darkPink.cgColor
        layer.addSublayer(borderLayer)
    }
}

