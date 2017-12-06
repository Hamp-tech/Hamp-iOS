//
//  ProfileCellButtonDelegate.swift
//  Hamp
//
//  Created by Aleix Baggerman on 29/11/2017.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation

protocol ProfileCellButtonDelegate: class {
    func signOut () -> ()
    func setupInfoController () -> ()
}
