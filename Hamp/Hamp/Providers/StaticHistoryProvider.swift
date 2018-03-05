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
                    DBTransaction.init(transaction: $0, creditCardNumber: "4444 4444 4444 4444")
                })

                self.hampDataManager.addDataArray(objects: dbTransactions)

            } else {
                print("ERROR DOWNLOADING TRANSACTIONS", response.message)
            }
        }
    }
    
    func getData () -> Results<Object> {
        return hampDataManager.getDataFromDB(type: DBTransaction.self)
    }
    
    func getDataWith(index: Int) -> Object {
        return hampDataManager.getDataFromDB(type: DBTransaction.self) [index]
    }
    
}
