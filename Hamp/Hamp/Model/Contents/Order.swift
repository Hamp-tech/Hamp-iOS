//
//  Order.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 17/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation

class Order {
    //MARK: Properties
    private var _orderableServices = [OrderableService]()
    public var count: Int {
        return _orderableServices.count
    }
    public var totalAmount: Float {
        return _orderableServices
            .filter { $0.service.amount > 0 }.reduce(Float(0.0), { (result, orderableService) in
                return result + Float(orderableService.service.amount) * orderableService.service.price
            })
    }
}


extension Order {
    //MARK: Public
    
    func removeAllServices () {
        self ._orderableServices.removeAll()
    }
    
    /// Add a service to order if services doesn't contains the service
    ///
    /// - Parameter service: service to add
    func add(service: OrderableService) {
        guard _orderableServices.index(where: {$0.service.identifier == service.service.identifier}) == nil else { return }
        _orderableServices.append(service)
    }
    
    /// Remove a services from order if contains the service
    ///
    /// - Parameter service: service to remove
    func remove(service: OrderableService) {
        if let idx = _orderableServices.index(where: {$0.service.identifier == service.service.identifier}) {
            _orderableServices.remove(at: idx)
        }
    }
    
    /// True if contains service, false otherwise
    ///
    /// - Parameter service: service to check
    /// - Returns: True = exists, false otherwise
    func contains(service: OrderableService) -> Bool {
        return _orderableServices.index(where: {$0.service.identifier == service.service.identifier}) != nil
    }
    
    /// Services hired
    ///
    /// - Returns: services
    func orderableServices() -> [OrderableService] {
        return _orderableServices
    }
    
    func services() -> [Service] {
        return _orderableServices.map{$0.service}
    }

    /// Remove services with amount = 0
    func removeEmptyServices() {
        _orderableServices = _orderableServices.filter { $0.service.amount > 0 }
    }
}
