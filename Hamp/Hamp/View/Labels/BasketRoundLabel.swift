//
//  BasketRoundLabel.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 16/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class BasketRoundLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    //MARK: Life cycle
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        borderColor = UIColor.white
        borderWidth = 1.5
        roundCorners()
    }
    
    //MARK: Private
    private func initialize() {
        backgroundColor = UIColor.darkPink
        textAlignment = .center
        textColor = .white
        font = UIFont.fredoka(withSize: 9)
    }
    
}

