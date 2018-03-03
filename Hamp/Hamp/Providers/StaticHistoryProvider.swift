//
//  StaticHistoryProvider.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 11/9/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation
import HampKit

class StaticHistoryProvider: HistoryProvider {
    
    // MARK: - Properties
    var transactions: [Transaction] = []
    
    // MARK: - API
    func download() {
        
        transactions.append(contentsOf: [])
    
    }
    
    
}
