//
//  UserContent.swift
//  Hamp
//
//  Created by Aleix Baggerman on 22/10/2017.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation

enum UserOption {
    case leftOption, rightOption, none
}

protocol UserContent {
    var cellID: String {get set}
    var labelText: String {get set}
    var textFieldText: String {get set}
    var firstOptionText: String {get set}
    var secondOptionText: String {get set}
    var firstOption: UserOption {get set}
}
