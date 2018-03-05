//
//  OrderHistoryContentProvider.swift
//  Hamp
//
//  Created by Aleix Baggerman on 05/03/2018.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class OrderHistoryContentProvider: OrderHistoryTableProvider {

    private var contents: [[OrderHistoryContent]]!
    
    init (transaction: DBTransaction) {
        contents = OrderHistoryContentFactory.createHistoryContent(transaction: transaction)
    }
    
    func numberOfSections() -> Int {
        return contents.count
    }
    
    func numberOfItems(section: Int) -> Int {
        return contents[section].count
    }
    
    func getContentWith(indexPath: IndexPath) -> OrderHistoryContent {
        return contents[indexPath.section][indexPath.item]
    }
}

