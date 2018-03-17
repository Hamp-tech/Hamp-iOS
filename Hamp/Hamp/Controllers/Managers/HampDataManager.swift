//
//  TransactionsDataManager.swift
//  Hamp
//
//  Created by Aleix Baggerman on 04/03/2018.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import Foundation
import RealmSwift

class HampDataManager {
    private var database: Realm!
    private let realmThreadName = "com.hamp.realmThread"
    private let realmQueue: DispatchQueue!
    
    init() {
        realmQueue = DispatchQueue.init(label: realmThreadName, attributes: .concurrent)
    }
    
    func createDataBase () {
        realmQueue.sync {  [unowned self] in
            self.database = try! Realm ()
        }
    }
    
    func getDataFromDB (type: Object.Type, onResponse: @escaping (Results<Object>)->()) {
        realmQueue.sync { [unowned self] in
            let results: Results<Object> = self.database.objects(type)
            onResponse (results)
        }
    }
    
    func getObjectFromDB (type: Object.Type, primaryKey: String, onResponse: @escaping (Object?) -> ()) {
        realmQueue.sync { [unowned self] in
            onResponse(self.database.object(ofType: type, forPrimaryKey: primaryKey))
        }
    }
    
    func addData(object: Object)   {
        realmQueue.sync { [unowned self] in
            try! self.database.write {
                self.database.add(object, update: true)
            }
        }
    }
    
    func addDataArray (objects: [Object]) {
        realmQueue.sync { [unowned self] in
            try! self.database.write {
                for object in objects {
                    self.database.add(object, update: true)
                }
            }
        }
    }
    
    func deleteAllFromDatabase()  {
        realmQueue.sync { [unowned self] in
            try! self.database.write {
                self.database.deleteAll()
            }
        }
    }
    
    func deleteFromDb(object: Object)   {
        realmQueue.sync { [unowned self] in
            try! self.database.write {
                self.database.delete(object)
            }
        }
    }
    
    func printDataBaseFileRoute () {
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }

}
