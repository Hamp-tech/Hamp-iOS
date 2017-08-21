//
//  TimeLinePointView.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 21/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class TimeLinePointView: UIView {
    
    private let size: CGFloat = 10
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
    
        let foo = CGRect.init(x: rect.width/2 - size/2, y: rect.height/2 - size/2, width: size, height: size)
        context.addEllipse(in: foo)
        context.setFillColor(UIColor.darkPink.cgColor)
        context.fillPath()
    }
    
    
}
