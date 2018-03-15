//
//  StaticHistoryProvider.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 11/9/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation
import HampKit
import RealmSwift

class StaticHistoryProvider: DataProvider {
    
    let hampDataManager: HampDataManager
    
    init (hampDataManager: HampDataManager) {
        self.hampDataManager = hampDataManager
    }
    
    // MARK: - API
    func download () {
        let userID = Hamp.Auth.user!.identifier!
        Hamp.Transactions.transactions(userID: userID) { (response) in
            if response.code == .ok {
                let transactions = response.data!
                let dbTransactions = transactions.map({
                    DBTransaction.init(transaction: $0)
                })

                self.hampDataManager.addDataArray(objects: dbTransactions)

            } else {
                print("ERROR DOWNLOADING TRANSACTIONS", response.message)
            }
        }
    }
    
    func getData (onResponse: @escaping (Results<Object>)->()) {
        hampDataManager.getDataFromDB(type: DBTransaction.self, onResponse: { (results) in
            onResponse (results)
        })
    }
    
    func getDataWith(index: Int, onResponse: @escaping (Object)->()) {
        hampDataManager.getDataFromDB(type: DBTransaction.self) { (results) in
            onResponse (results[index])
        }
    }
    
}
