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
    private var _services = [Service]()
    public var count: Int {
        return _services.count
    }
    public var totalAmount: Int {
        return _services
            .filter { $0.amount > 0 }
            .reduce(0) {(initial, service) in
                initial + service.amount*service.price
        }
    }
}

extension Order {
    //MARK: Public
    
    /// Add a service to order if services doesn't contains the service
    ///
    /// - Parameter service: service to add
    func add(service: Service) {
        guard _services.index(where: {$0.identifier == service.identifier}) == nil else { return }
        _services.append(service)
    }
    
    /// Remove a services from order if contains the service
    ///
    /// - Parameter service: service to remove
    func remove(service: Service) {
        if let idx = _services.index(where: {$0.identifier == service.identifier}) {
            _services.remove(at: idx)
        }
    }
    
    /// True if contains service, false otherwise
    ///
    /// - Parameter service: service to check
    /// - Returns: True = exists, false otherwise
    func contains(service: Service) -> Bool {
        return _services.index(where: {$0.identifier == service.identifier}) != nil
    }
    
    /// Services hired
    ///
    /// - Returns: services
    func services() -> [Service] {
        return _services
    }

    /// Remove services with amount = 0
    func removeEmptyServices() {
        _services = _services.filter { $0.amount > 0 }
    }
}
