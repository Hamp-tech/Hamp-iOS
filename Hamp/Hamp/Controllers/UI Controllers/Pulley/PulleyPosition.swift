//
//  PulleyPosition.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 14/9/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation

/**
 Represents a Pulley drawer position.
 
 - collapsed:         When the drawer is in its smallest form, at the bottom of the screen.
 - partiallyRevealed: When the drawer is partially revealed.
 - open:              When the drawer is fully open.
 - closed:            When the drawer is off-screen at the bottom of the view. Note: Users cannot close or reopen the drawer on their own. You must set this programatically
 */
public enum PulleyPosition: Int {
    
    case collapsed = 0
    case open = 1
    
    public static let all: [PulleyPosition] = [
        .collapsed,
        .open,
    ]
}

