//
//  TransactionFactory.swift
//  Hamp
//
//  Created by Aleix Baggerman on 03/03/2018.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import Foundation
import HampKit

struct TransactionFactory {
    static func createTransaction (services: [OrderableService], amount: Float, creditCardID: String) -> Transaction {
        var hiredServices = [HiredService] ()
        
        services.forEach({
            let hiredService = HiredService.init(service: $0.service.name, amount: $0.service.amount)
            hiredServices.append(hiredService)
        })

        let booking = Booking.init(basket: hiredServices, price: Float32(amount), point: "1", pickUpTime: Booking.PickUpTime.afternoon)
        
        return Transaction.init(booking: booking, creditCardIdentifier: creditCardID)
    }
}
