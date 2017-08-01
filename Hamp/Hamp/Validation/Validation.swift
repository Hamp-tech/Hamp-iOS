//
//  Validation.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 1/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation

public class Validation {
    typealias ValidationBlock = () -> (Bool)
    typealias ValidatedBlock = (String, Bool) -> ()
    
    var validationBlock: ValidationBlock
    var validatedBlock: ValidatedBlock
    
    init(by validationBlock: @escaping ValidationBlock,
         validatedBlock: @escaping ValidatedBlock) {
        self.validationBlock = validationBlock
        self.validatedBlock = validatedBlock
    }
}
