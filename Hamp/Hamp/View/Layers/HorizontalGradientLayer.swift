//
//  HorizontalGradientLayer.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 22/7/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class HorizontalGradientLayer: CAGradientLayer {
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

private extension HorizontalGradientLayer {
    /// Setup gradient 
    func setup() {
        colors = [UIColor.darkPink.cgColor, UIColor.ligthPink.cgColor]
        startPoint = CGPoint(x: 1.0, y: 0.5)
        endPoint = CGPoint(x: 0.0, y: 0.5);
    }
}
