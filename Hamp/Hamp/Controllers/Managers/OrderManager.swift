//
//  OrderManager.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 17/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation

protocol OrderManagerDelegate: class {
    func orderWasUpdated(on manager: OrderManager)
    func orderWasEmptied(on manager: OrderManager)
}

final class OrderManager {
    /// Properties
    public private(set) var order: Order = Order.init()
    weak var delegate: OrderManagerDelegate?
}

extension OrderManager {
    /// Add service to order if not exists
    ///
    /// - Parameter service: service to add
    func addIfNotExists(service: OrderableService) {
        if !order.contains(service: service), service.service.amount > 0 {
            order.add(service: service)
        }
        
        delegate?.orderWasUpdated(on: self)
        
    }
    
    /// Remove service from order if exists
    ///
    /// - Parameter service: service to remove
    func deleteServiceIfAmountZero(service: OrderableService) {
        if order.contains(service: service), service.service.amount == 0 {
             order.remove(service: service)
        }
        
        callDelegateDeppendsOnOrderContent()
    }
    
    /// Remove services with 0 amount
    func removeEmptyServices() {
        order.removeEmptyServices()
        callDelegateDeppendsOnOrderContent()
    }
    
    /// Number of services hired
    ///
    /// - Returns: Number of services hired
    func amountServicesHired() -> Int {
        return order.services().reduce(0) {(initial, service) in
            initial + service.amount
        }
    }
    
    /// Differents services hired
    ///
    /// - Returns: services hired
    func servicesHired() -> [OrderableService] {
        return order.orderableServices()
    }
    
    func removeServicesHired () {
        self.order.removeAllServices()
    }
}

private extension OrderManager {
    func callDelegateDeppendsOnOrderContent() {
        if amountServicesHired() == 0 { delegate?.orderWasEmptied(on: self) }
        else { delegate?.orderWasUpdated(on: self) }
    }
}
