//
//  OrdenServicesFactory.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 16/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation

public struct LaundryServicesProvider {
    
    /// Orden services to show on ServicesViewController
    static let orderServices = createOrderServices()
}

private extension LaundryServicesProvider {
    static func createOrderServices() -> [OrderableService] {
        var services = [OrderableService]()
        services.append(orderService(service: LaundryServicesFactory.service(by: .smallBag), by: "small-bag"))
        services.append(orderService(service: LaundryServicesFactory.service(by: .bigBag), by: "big-bag"))
        services.append(orderService(service: LaundryServicesFactory.service(by: .sofaCover), by: "sofa-cover"))
        services.append(orderService(service: LaundryServicesFactory.service(by: .blanket), by: "blanket"))
        services.append(orderService(service: LaundryServicesFactory.service(by: .curtain), by: "curtain"))
        services.append(orderService(service: LaundryServicesFactory.service(by: .cushion), by: "cushion"))
        services.append(orderService(service: LaundryServicesFactory.service(by: .smallQuilt), by: "small-quilt"))
        services.append(orderService(service: LaundryServicesFactory.service(by: .bigQuilt), by: "big-quilt"))
        
        return services
        
    }
    
    private static func orderService(service: Service, by imageName: String) -> OrderableService {
        return OrderService(service: service, imageName: imageName)
    }
	
	
}
