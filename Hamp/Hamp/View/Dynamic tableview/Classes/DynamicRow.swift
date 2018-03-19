//
//  DynamicRow.swift
//  DynamicTableViewController
//
//  Created by Joan Molinas Ramon on 26/8/17.
//  Copyright © 2017 Joan Molinas Ramon. All rights reserved.
//

import UIKit

public class DynamicRow: DynamicRowable {
    var identifier: String
    var backgroundColor: UIColor
    
    required public init(identifier: String, backgroundColor: UIColor) {
        self.identifier = identifier
        self.backgroundColor = backgroundColor
    }
    

}
