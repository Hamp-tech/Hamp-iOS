//
//  VerticalGradientButton.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 18/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class VerticalGradientButton: UIButton {

    //MARK: Properties
    let gradient = VerticalGradientLayer()
    
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
