//
//  NavigationsBarRightButtonsFactory.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 16/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

struct BarRightButtonsFactory {
    static func basketButton() -> BasketButton {
        let button = BasketButton.init(type: .system)
        button.frame = CGRect.init(x: 0, y: 0, width: 30, height: 24)
        button.setImage(#imageLiteral(resourceName: "basket-disabled"), for: .disabled)
        button.setImage(#imageLiteral(resourceName: "basket-enabled"), for: .normal)
        return button
    }
    
    static func videoTutorialButton() -> UIButton {
        let button = UIButton.init(type: .system)
        button.frame = CGRect.init(x: 0, y: 0, width: 26, height: 26)
        button.setImage(#imageLiteral(resourceName: "video-tutorial"), for: .normal)
        return button
    }
    
    
}
