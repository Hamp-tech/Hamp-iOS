//
//  HistoryProvider.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 11/9/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation
import HampKit

protocol HistoryProvider: DataProvider {
    var transactions: [Transaction] { get }
    
}
