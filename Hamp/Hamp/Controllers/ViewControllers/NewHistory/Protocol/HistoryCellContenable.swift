//
//  HistoryCellContenable.swift
//  Hamp
//
//  Created by Aleix Baggerman on 05/04/2018.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import Foundation

protocol HistoryCellContenable {
    var locationTitle: String! {get}
    var state: String! {get}
    var price: String! {get}
    var color: String! {get}
    
    init (locationTitle: String, state: String, price: String, color: String)
}
