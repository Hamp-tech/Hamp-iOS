//
//  ServicesFactory.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 17/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation

enum ServiceType: String {
    case smallBag = "smallBag"
    case bigBag = "bigBag"
    case curtain = "curtain"
    case cushion = "cushion"
    case sofaCover = "sofaCover"
    case smallQuilt = "smallQuilt"
    case bigQuilt = "bigQuilt"
    case blanket = "blanket"
}

struct ServicesFactory {
    static func service(by type: ServiceType) -> Service {
        return LaundryService.init(identifier: type.rawValue)
    }
}
