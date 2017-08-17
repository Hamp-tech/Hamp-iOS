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
    
    /// Add a service to order
    ///
    /// - Parameter service: service to add
    func add(service: Service) {
        _services.append(service)
    }
    
    /// Remove a services from order
    ///
    /// - Parameter service: service to remove
    func remove(service: Service) {
        if let idx = _services.index(where: {$0.identifier == service.identifier}) {
            _services.remove(at: idx)
        }
    }
    
    func services() -> [Service] {
        return _services
    }
}
