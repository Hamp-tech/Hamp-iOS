//
//  HistoryDetailContentFactory.swift
//  Hamp
//
//  Created by Aleix Baggerman on 24/03/2018.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import Foundation
import HampKit

struct HistoryDetailContentFactory {
    
    static func createCellsContent (transaction: DBTransaction) -> [[HistoryDetailContent]]{
                
        let detalles = [HistoryDetailCellContent (title: "Precio", detail: String(transaction.booking!.price) + " €"),
        HistoryDetailCellContent (title: "Fecha entrega", detail: transaction.pickUpDate),
        HistoryDetailCellContent (title: "Fecha recogida", detail: transaction.pickUpDate.isEmpty ? "-" : transaction.pickUpDate),
        HistoryDetailCellContent (title: "Método de pago", detail: "Visa acabada en " + transaction.creditCardNumber),
        HistoryDetailCellContent (title: "Horario de recogida", detail: transaction.booking!.pickUpTime == 0 ? "Mañana" : "Tarde")]
        
        let servicios: [HistoryDetailContent] = transaction.booking!.services.map({
            let detail = String($0.amount) + " x " + String ($0.price) + " €"
            return HistoryDetailCellContent.init(title: $0.name, detail: detail)
        })
        
        let pickUpLockers: [HistoryDetailContent] = transaction.booking!.pickUpLockers.map({
            let title = "Numero: " + String($0.number)
            let detail = "Còdigo: " + $0.code
            return HistoryDetailCellContent.init(title: title, detail: detail)
        })
        
        let deliveryLockers: [HistoryDetailContent] = transaction.booking!.deliveryLockers.map({
            let title = "Numero: " + String($0.number)
            let detail = "Còdigo: " + $0.code
            return HistoryDetailCellContent.init(title: title, detail: detail)
        })
    
        let point = transaction.booking!.point!
        
        let direccion = [
            HistoryDetailCellContent.init(title: "Punto", detail: point.location!.name),
            HistoryDetailCellContent.init(title: "Calle", detail: point.address),
            HistoryDetailCellContent.init(title: "Pueblo", detail: point.city)
        ]
        if deliveryLockers.isEmpty {
            return [detalles,servicios, pickUpLockers, direccion]
        }
        return [detalles,servicios,pickUpLockers, deliveryLockers, direccion]
    }
    
}
