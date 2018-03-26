//
//  RealmList + Array.swift
//  Hamp
//
//  Created by Aleix Baggerman on 05/03/2018.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import Foundation
import RealmSwift

extension List {
    func toArray<T>(ofType: T.Type) -> [T] {
        return self.map({
            $0 as! T
        })
    }
    
    convenience init(elements: [Element]) {
        self.init()
        elements.forEach(add)
    }
    
    private func add(element: Element) {
        append(element)
    }
}
