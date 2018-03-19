//
//  DynamicRowable.swift
//  DynamicTableViewController
//
//  Created by Joan Molinas Ramon on 26/8/17.
//  Copyright © 2017 Joan Molinas Ramon. All rights reserved.
//

import UIKit

protocol DynamicRowable {
    var identifier: String {get}
    var backgroundColor: UIColor {get set}
    
    init(identifier: String, backgroundColor: UIColor)
}
