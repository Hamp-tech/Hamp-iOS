//
//  LaundryServicesFactory.swift
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
    static func service(by type: ServiceType, price: Int = 1) -> Service {
        return LaundryService.init(identifier: type.rawValue, price: price, name: type.name)
    }
}
