//
//  Reusable.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 31/7/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

protocol Reusable: class {
    static var reuseIdentifier: String { get }
    static var nib: UINib? { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String.init(describing: self)
        
    }
    static var nib: UINib? {
        return UINib.init(nibName: reuseIdentifier, bundle: nil)
    }
}

