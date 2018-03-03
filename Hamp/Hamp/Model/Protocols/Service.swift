//
//  Service.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 17/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation

protocol Service {
    var identifier: String { get set }
    var amount: Int { get set }
    var price: Float { get set }
    var name: String { get set }
}
