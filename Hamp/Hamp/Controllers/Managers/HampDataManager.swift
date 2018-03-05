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
    private var database: Realm
    
    init () {
        self.database = try! Realm ()
    }
    
    func getDataFromDB (type: Object.Type) ->   Results<Object> {
        let results: Results<Object> = database.objects(type)
        return results
    }
    
    func getObjectFromDB (type: Object.Type, primaryKey: String) -> Object? {
        return database.object(ofType: type, forPrimaryKey: primaryKey)
    }
    
    func addData(object: Object)   {
        try! database.write {
            database.add(object, update: true)
        }
    }
    
    func addDataArray (objects: [Object]) {
        let list = convertArrayToList(array: objects)
        DispatchQueue.main.async {
            try! self.database.write {
                for object in list {
                    self.database.add(object, update: true)
                }
            }
        }
    }
    
    private func convertArrayToList (array: [Object]) -> List<Object> {
        let list = List<Object>()
        for element in array {
            list.append(element)
        }
        return list
    }
    
    func deleteAllFromDatabase()  {
        DispatchQueue.main.async {
            try! self.database.write {
                self.database.deleteAll()
            }
        }
    }
    
    func deleteFromDb(object: Object)   {
        DispatchQueue.main.async {
            try! self.database.write {
                self.database.delete(object)
            }
        }
    }
    
    func printDataBaseFileRoute () {
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }

}
