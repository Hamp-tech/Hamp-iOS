//
//  DynamicDataSource.swift
//  DynamicTableViewController
//
//  Created by Joan Molinas Ramon on 26/8/17.
//  Copyright © 2017 Joan Molinas Ramon. All rights reserved.
//

import UIKit

class DynamicDataSource {
    public private(set) var sections = [DynamicSection]()
    
    func add(section: DynamicSection) {
        sections.append(section)
    }
    
    func numberOfSections() -> Int {
        return sections.count
    }
    
    func numberOfRows(in section: Int) -> Int {
        return sections[section].numberOfRows()
    }
    
    func row(atSection section: Int, rowIndex: Int) -> DynamicRowable {
        return sections[section].rows[rowIndex]
    }
}
