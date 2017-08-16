//
//  OrdenServicesFactory.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 16/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation

public struct OrderServicesProvider {
    
    /// Orden services to show on ServicesViewController
    static let orderServices = createOrderServices()
}

private extension OrderServicesProvider {
    static func createOrderServices() -> [OrderableService] {
        var services = [OrderableService]()
        services.append(orderService(by: "small-bag", name: "Small Bag"))
        services.append(orderService(by: "big-bag", name: "Big Bag"))
        services.append(orderService(by: "sofa-cover", name: "Sofa cover"))
        services.append(orderService(by: "blanket", name: "Blanket"))
        services.append(orderService(by: "curtain", name: "Curtain"))
        services.append(orderService(by: "cushion", name: "Cushion"))
        services.append(orderService(by: "small-quilt", name: "Small quilt"))
        services.append(orderService(by: "big-quilt", name: "Big quilt"))
        
        return services
        
    }
    
    static func orderService(by imageName: String, name: String) -> OrderableService {
        return OrderService.init(imageName: imageName, name: name)
    }
}
