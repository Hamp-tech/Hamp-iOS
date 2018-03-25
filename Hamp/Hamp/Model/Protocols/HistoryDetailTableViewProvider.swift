//
//  HistoryDetailTableViewProvider.swift
//  Hamp
//
//  Created by Aleix Baggerman on 24/03/2018.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import Foundation

protocol HistoryDetailTableViewProvider {
    func numberOfSections () -> Int
    func numberOfRowsInSection (section: Int) -> Int
    func getSectionTitle (section: Int) -> String
    func contentWith (indexPath: IndexPath) -> HistoryDetailContent
}
