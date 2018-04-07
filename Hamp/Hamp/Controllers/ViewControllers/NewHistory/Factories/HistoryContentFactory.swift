//
//  HistoryContentFactory.swift
//  Hamp
//
//  Created by Aleix Baggerman on 05/04/2018.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import Foundation

class HistoryContentFactory {
    
    static func create (transaction: DBTransaction) -> HistoryCellContenable {
        
        let state = transaction.booking!.deliveryLockers == nil ? "Lavandose" : "Listo para recoger"
        
        return HistoryCellContent(locationTitle: transaction.booking!.point!.location!.name, state: state, price: String(transaction.booking!.price) + " €", color: "")
    }
}
