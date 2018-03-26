//
//  HistoryDetailCellsProvider.swift
//  Hamp
//
//  Created by Aleix Baggerman on 24/03/2018.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import Foundation

class HistoryDetailCellsProvider: HistoryDetailTableViewProvider {
    
    // MARK: - Properties
    private var content: [[HistoryDetailContent]]!
    private lazy var sectionTitles: [String] = {
        var sectionTitles = ["Detalles", "Servicios", "Taquillas de entrega", "Direccion"]
        if let lockers = transaction.booking?.deliveryLockers, !lockers.isEmpty {
            sectionTitles.insert("Taquillas de recogida", at: 3)
        }
        
        return sectionTitles
    }()
    private var transaction: DBTransaction
    
    // MARK: - Life cycle
    init (transaction: DBTransaction) {
        content = HistoryDetailContentFactory.createCellsContent(transaction: transaction)
        
        self.transaction = transaction
    }
    
    // MARK: - API
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
