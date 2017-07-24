//
//  GradientButton.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 22/7/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class GradientButton: UIButton {

    //MARK: Properties
    let gradient = GradientLayer()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        gradient.frame = bounds
        layer.insertSublayer(gradient, at: 0)
        layer.masksToBounds = true
        layer.cornerRadius = rect.height/2
    }
    
    override var isEnabled:Bool {
        didSet {
            alpha = isEnabled ? 1 : 0.5
        }
    }
}
