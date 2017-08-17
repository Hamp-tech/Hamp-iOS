//
//  OrderTests.swift
//  HampTests
//
//  Created by Joan Molinas Ramon on 17/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import XCTest
@testable import Hamp

class OrderTests: XCTestCase {
    private var services: [LaundryService] = [LaundryService.init(identifier: "111", price: 1, name: "111", amount: 1),
                                              LaundryService.init(identifier: "222", price: 2, name: "222", amount: 1),
                                              LaundryService.init(identifier: "333", price: 3, name: "333", amount: 1),
                                              LaundryService.init(identifier: "444", price: 4, name: "444", amount: 1),
                                              LaundryService.init(identifier: "555", price: 5, name: "555", amount: 1)]
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testOrder_empty() {
        let order = Order.init()
        XCTAssertEqual(order.count, 0)
    }
    
    func testOrder_add() {
        let order = Order.init()
        order.add(service: services[0])
        order.add(service: services[1])
        order.add(service: services[2])
        XCTAssertEqual(order.count, 3)
    }
    
    func testOrder_removeAddedElements() {
        let order = Order.init()
        order.add(service: services[0])
        order.add(service: services[1])
        order.add(service: services[2])
        XCTAssertEqual(order.count, 3)
        order.remove(service: services[0])
        XCTAssertEqual(order.count, 2)
        
        XCTAssertEqual(order.services()[0].identifier, services[1].identifier)
        XCTAssertEqual(order.services()[1].identifier, services[2].identifier)
    }
    
    func testOrder_removeNonExistingElements() {
        let order = Order.init()
        order.add(service: services[0])
        order.add(service: services[1])
        order.add(service: services[2])
        XCTAssertEqual(order.count, 3)
        order.remove(service: services[4])
        XCTAssertEqual(order.count, 3)
    }
    
    func testOrder_services() {
        let order = Order.init()
        order.add(service: services[0])
        order.add(service: services[1])
        order.add(service: services[2])

        XCTAssertEqual(order.services()[0].identifier, services[0].identifier)
        XCTAssertEqual(order.services()[1].identifier, services[1].identifier)
        XCTAssertEqual(order.services()[2].identifier, services[2].identifier)
    }
    
    func testOrder_totalAmountEmpty() {
        let order = Order.init()
        XCTAssertEqual(order.totalAmount, 0)
    }
    
    func testOrder_totalAmountSomeElements() {
        let order = Order.init()
        
        order.add(service: services[0])
        order.add(service: services[1])
        order.add(service: services[2])
        
        
        XCTAssertEqual(order.totalAmount, 6)
    }
    
    func testOrder_totalAmountSomeElementsWithDifferentAmounts() {
        let order = Order.init()
        
        services[0].amount += 1
        services[1].amount += 2
        services[2].amount += 1
        
        order.add(service: services[0])
        order.add(service: services[1])
        order.add(service: services[2])
        
        
        XCTAssertEqual(order.totalAmount, 14)
    }
    
    func testOrder_containsExistingElement() {
        let order = Order.init()
        
        order.add(service: services[0])
        order.add(service: services[1])
        order.add(service: services[2])
        
        XCTAssertTrue(order.contains(service: services[0]))
        XCTAssertTrue(order.contains(service: services[1]))
        XCTAssertTrue(order.contains(service: services[1]))
    }
    
    func testOrder_containsNonExistingElement() {
        let order = Order.init()
        
        order.add(service: services[0])
        order.add(service: services[1])
        order.add(service: services[2])
        
        XCTAssertFalse(order.contains(service: services[4]))
    }
    
    func testOrder_removeEmptyServices() {
        let order = Order.init()
        
        services[0].amount = 0
        services[1].amount = 0
        services[2].amount = 0
        
        order.add(service: services[0])
        order.add(service: services[1])
        order.add(service: services[2])
        
        order.removeEmptyServices()
        XCTAssertEqual(order.count, 0)
        XCTAssertFalse(order.contains(service: services[0]))
    }
    
    func testOrder_removeEmptyServicesNotAll() {
        let order = Order.init()
        
        services[1].amount = 0
        services[2].amount = 0
        
        order.add(service: services[0])
        order.add(service: services[1])
        order.add(service: services[2])
        
        order.removeEmptyServices()
        XCTAssertEqual(order.count, 1)
        XCTAssertTrue(order.contains(service: services[0]))
        XCTAssertFalse(order.contains(service: services[1]))
    }
}
