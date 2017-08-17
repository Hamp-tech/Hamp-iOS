//
//  OrderManager.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 17/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation

final class OrderManager {
    /// Properties
    public private(set) var order: Order
    
    /// Create a new order manager
    ///
    /// - Parameter order: order
    init(order: Order) {
        self.order = order
    }
}

extension OrderManager {
    /// Add service to order if not exists
    ///
    /// - Parameter service: service to add
    func addIfNotExists(service: Service) {
        guard !order.contains(service: service), service.amount > 0 else { return }
        order.add(service: service)
    }
    
    /// Remove service from order if exists
    ///
    /// - Parameter service: service to remove
    func deleteServiceIfAmountZero(service: Service) {
        guard order.contains(service: service), service.amount == 0 else { return }
        order.remove(service: service)
    }
    
    /// Remove services with 0 amount
    func removeEmptyServices() {
        order.removeEmptyServices()
    }
}
