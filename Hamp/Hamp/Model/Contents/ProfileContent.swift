//
//  ProfileContent.swift
//  Hamp
//
//  Created by Aleix Baggerman on 22/10/2017.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation
import HampKit

class ProfileContent: UserContent {

    var cellID: String
    var labelText: String
    var textFieldText: String
    var firstOptionText: String
    var secondOptionText: String = ""
    var firstOption: UserOption
    var actionBlock: (() -> ())?
    
    required init(cellID: String,
         labelText: String = "",
         textFieldText: String = "",
         firstOptionText: String = "",
         secondOptionText: String = "",
         firstOption: UserOption = .none,
         actionBlock: (()->())? = nil) {
        self.cellID = cellID
        self.labelText = labelText
        self.textFieldText = textFieldText
        self.firstOptionText = firstOptionText
        self.secondOptionText = secondOptionText
        self.firstOption = firstOption
        self.actionBlock = actionBlock
    }
    
    
    

}
