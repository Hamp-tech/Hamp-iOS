//
//  LaundryServicesFactory.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 17/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation

enum ServiceType: String {
    case smallBag = "1"
    case bigBag = "2"
    case curtain = "3"
    case cushion = "4"
    case sofaCover = "5"
    case smallQuilt = "6"
    case bigQuilt = "7"
    case blanket = "8"
    
    var name: String {
        switch self {
        case .smallBag:
            return "Small bag"
        case .bigBag:
            return "Big bag"
        case .curtain:
            return "Curtain"
        case .cushion:
            return "Cushion"
        case .sofaCover:
            return "Sofa cover"
        case .smallQuilt:
            return "Small quilt"
        case .bigQuilt:
            return "Big quilt"
        case .blanket:
            return "Blanket"
        }
    }
}

struct LaundryServicesFactory {
    static func service(by type: ServiceType, price: Float = 1) -> Service {
        return LaundryService.init(identifier: type.rawValue, price: price, name: type.name, amount: 0)
    }
}
