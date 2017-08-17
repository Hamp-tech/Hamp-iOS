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
        services.append(orderService(service: ServicesFactory.service(by: .smallBag), by: "small-bag", name: "Small Bag"))
        services.append(orderService(service: ServicesFactory.service(by: .bigBag), by: "big-bag", name: "Big Bag"))
        services.append(orderService(service: ServicesFactory.service(by: .sofaCover), by: "sofa-cover", name: "Sofa cover"))
        services.append(orderService(service: ServicesFactory.service(by: .blanket), by: "blanket", name: "Blanket"))
        services.append(orderService(service: ServicesFactory.service(by: .curtain), by: "curtain", name: "Curtain"))
        services.append(orderService(service: ServicesFactory.service(by: .cushion), by: "cushion", name: "Cushion"))
        services.append(orderService(service: ServicesFactory.service(by: .smallQuilt), by: "small-quilt", name: "Small quilt"))
        services.append(orderService(service: ServicesFactory.service(by: .bigQuilt), by: "big-quilt", name: "Big quilt"))
        
        return services
        
    }
    
    private static func orderService(service: Service, by imageName: String, name: String) -> OrderableService {
        return OrderService.init(service: service, imageName: imageName, name: name)
    }
}
