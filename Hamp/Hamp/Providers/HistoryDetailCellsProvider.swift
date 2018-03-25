//
//  HistoryDetailCellsProvider.swift
//  Hamp
//
//  Created by Aleix Baggerman on 24/03/2018.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import Foundation

struct HistoryDetailCellsProvider: HistoryDetailTableViewProvider {
    
    var content: [[HistoryDetailContent]]!
    var sectionTitles = ["Detalles", "Servicios", "Taquillas de entrega", "Taquillas de recogida", "Direccion"]
    
    init (transaction: DBTransaction) {
        content = HistoryDetailContentFactory.createCellsContent(transaction: transaction)
        if content.count < sectionTitles.count {
            sectionTitles.remove(at: 3)
        }
    }
    func numberOfSections() -> Int {
        return content.count
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return content[section].count
    }
    
    func contentWith(indexPath: IndexPath) -> HistoryDetailContent {
        return content[indexPath.section][indexPath.row]
    }
    
    func getSectionTitle(section: Int) -> String {
        return sectionTitles[section]
    }
    
    
    
}
