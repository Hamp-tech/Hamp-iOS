//
//  BasketButton.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 16/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class BasketButton: UIButton {
    
    //MARK: Properties
    var amountLabel: UILabel!
    let size: CGFloat = 17
    
    override var isEnabled: Bool {
        didSet {
            guard let l = amountLabel else { return }
            l.alpha = isEnabled ? 1 : 0
        }
    }
    
    //MARK: life cycle
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupLabel()
    }
    
    public func setupLabel() {
        guard amountLabel == nil else { return }
        amountLabel = BasketRoundLabel.init(frame: CGRect.init(x: 0, y: 0, width: size, height: size))
        amountLabel.center = CGPoint.init(x: bounds.width-size/2, y: bounds.height)
        amountLabel.alpha = isEnabled ? 1 : 0
        addSubview(amountLabel)
    }
    
    //MARK: Public
    func updateAmount(with amount: Int) {
//        isEnabled = amount > 0
        guard let al = amountLabel else { return }
        al.text = String.init(amount)
    }
}
