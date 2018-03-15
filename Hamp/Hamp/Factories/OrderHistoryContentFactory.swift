//
//  OrderHistoryContentFactory.swift
//  Hamp
//
//  Created by Aleix Baggerman on 05/03/2018.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import UIKit
import HampKit

class OrderHistoryContentFactory {
    
    static func createHistoryContent (transaction: DBTransaction) -> [[OrderHistoryContent]] {
        let lockerImage =  #imageLiteral(resourceName: "locker").withRenderingMode(.alwaysOriginal)
        //TO-DO CHANGE PADLOCK IMAGE
        let padlockImage = #imageLiteral(resourceName: "clock-empty").withRenderingMode(.alwaysOriginal)
        return [[
            OrderHistoryCellContent.init(identifier: OrderCellsID.payment, title: "Método de pago", images:[#imageLiteral(resourceName: "credit-card")], creditCardNumber: transaction.creditCardNumber),
            OrderHistoryCellContent.init(identifier: OrderCellsID.description, title: "Descripción", services: transaction.booking?.services.toArray(ofType: LaundryService.self)),
            OrderHistoryCellContent.init(identifier: OrderCellsID.info, title: "Entrega", images: [lockerImage, padlockImage], lockers: transaction.booking?.pickUpLockers.toArray(ofType: DBLocker.self)),
            OrderHistoryCellContent.init(identifier: OrderCellsID.info, title: "Recogida", images: [lockerImage, padlockImage], lockers: transaction.booking?.deliveryLockers.toArray(ofType: DBLocker.self))
        ]]
    }
    
}
