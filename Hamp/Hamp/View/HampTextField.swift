//
//  HampTextField.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 23/7/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class HampTextField: UITextField {

    //MARK: Properties
    public var textState: TextState = .empty {
        willSet(newValue){
            if newValue == .empty {
                color = .black
            } else {
                color = .darkPink
            }
            
            setNeedsDisplay()
        }
    }
    private var color: UIColor = .black
    
    //MARK: Life cycle
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupBorderBottom()
        setupProperties()
    }
}

extension HampTextField {
    enum TextState {
        case filled
        case empty
    }
}

private extension HampTextField {
    //MARK: Private
    
    /// Add a border bottom to textfield
    func setupBorderBottom() {
        let borderLayer = CALayer()
        borderLayer.frame = CGRect(x: 0, y: bounds.height-2, width: bounds.width, height: 2)
        borderLayer.backgroundColor = color.cgColor
        layer.addSublayer(borderLayer)
    }
    
    /// Set text default properties
    func setupProperties() {
        textAlignment = .center
        font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        textColor = color
        tintColor = color
        autocorrectionType = .no
        
        if let placeholder = placeholder {
            let str = NSAttributedString(string: placeholder, attributes: [NSAttributedStringKey.foregroundColor:UIColor.black])
            self.attributedPlaceholder = str
        }

    }

}
