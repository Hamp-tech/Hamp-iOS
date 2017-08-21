//
//  HorizontalGradientButton.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 22/7/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class HorizontalGradientButton: UIButton {

    //MARK: Properties
    let gradient = HorizontalGradientLayer()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        gradient.frame = bounds
        layer.insertSublayer(gradient, at: 0)
        roundCorners()
    }
    
    override var isEnabled:Bool {
        didSet {
            alpha = isEnabled ? 1 : 0.5
        }
    }
}
