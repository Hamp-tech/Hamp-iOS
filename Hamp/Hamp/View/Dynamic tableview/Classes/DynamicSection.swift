//
//  DynamicSection.swift
//  DynamicTableViewController
//
//  Created by Joan Molinas Ramon on 26/8/17.
//  Copyright © 2017 Joan Molinas Ramon. All rights reserved.
//

import Foundation

class DynamicSection {
    public private(set) var rows = [DynamicRow]()
    
    func add(row: DynamicRow) {
        rows.append(row)
    }
    
    func numberOfRows() -> Int {
        return rows.count
    }
}
