//
//  VerticalGradientLayer.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 18/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class VerticalGradientLayer: CAGradientLayer {
    //MARK: Constructors
    override init() {
        super.init()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}

private extension VerticalGradientLayer {
    /// Setup gradient
    func setup() {
        colors = [UIColor.darkPink.cgColor, UIColor.ligthPink.cgColor]
        startPoint = CGPoint(x: 0.5, y: 1.0)
        endPoint = CGPoint(x: 0.5, y: 0.0)
    }
}

