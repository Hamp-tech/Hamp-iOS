//
//  ProvidersManager.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 12/9/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation

struct ProvidersManager {
    
    // MARK: - Properties
    static let sharedInstance = ProvidersManager.init()
    let hampDataManager: HampDataManager
    let historyProvider: StaticHistoryProvider
    
    private init () {
        hampDataManager = HampDataManager.init()
        hampDataManager.createDataBase()
        historyProvider = StaticHistoryProvider.init(hampDataManager: hampDataManager)
    }
    
    // MARK: - Public API
    func downloadProvidersData() {
        self.historyProvider.download()
    }
}
