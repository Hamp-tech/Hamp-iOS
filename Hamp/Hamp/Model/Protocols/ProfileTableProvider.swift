//
//  ProfileTableProvider.swift
//  Hamp
//
//  Created by Aleix Baggerman on 22/10/2017.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation

protocol ProfileTableProvider {
    func numberOfSections () -> Int
    func numberOfItems (at section: Int) -> Int
    func content (at indexPath: IndexPath) -> UserContent?
    func setCellsEnabled (enabled: Bool)
    func areCellsEnabled ()->Bool
}
