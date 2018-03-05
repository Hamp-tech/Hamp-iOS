//
//  OrderHistoryTableProvider.swift
//  Hamp
//
//  Created by Aleix Baggerman on 05/03/2018.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import Foundation

protocol OrderHistoryTableProvider {
    func numberOfSections () -> Int
    func numberOfItems (section: Int) -> Int
    func getContentWith (indexPath: IndexPath) -> OrderHistoryContent
}
