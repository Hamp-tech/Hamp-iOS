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
        button.setImage(#imageLiteral(resourceName: "basket-disabled"), for: .disabled)
        button.setImage(#imageLiteral(resourceName: "basket-enabled"), for: .normal)
        return button
    }
}
