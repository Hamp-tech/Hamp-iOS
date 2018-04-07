//
//  HistoryCellContent.swift
//  Hamp
//
//  Created by Aleix Baggerman on 05/04/2018.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import Foundation

class HistoryCellContent: HistoryCellContenable {
    var color: String!
    var locationTitle: String!
    var state: String!
    var price: String!
    
    required init(locationTitle: String, state: String, price: String, color: String) {
        self.locationTitle = locationTitle
        self.state = state
        self.price = price
        self.color = color
    }
    
    

}
