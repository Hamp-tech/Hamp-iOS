//
//  SingUpContentableCell.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 31/7/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation

public protocol SignUpContentableCell {
    var content: SignUpCellContent! { get set }
    func configure()
}
