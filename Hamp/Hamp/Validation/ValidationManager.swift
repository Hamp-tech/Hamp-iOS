//
//  File.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 1/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation

public struct ValidationManager {
    
    //MARK: Validation
    private var validations = [String: Validation]()
    
    //MARK: Public
    public mutating func add(by validation: Validation) {
        self.validations[validation.key] = validation
    }
    
    public func validate(onSuccess: () -> (),
                         onError: () -> ()) {
        var allValid = true
        
        validations.forEach {
            let valid = $0.value.validationBlock()
            $0.value.validatedBlock($0.key, valid)
            if allValid { allValid = valid }
        }
        
        allValid ? onSuccess() : onError()
    }
    
    public func check(onSuccess: () -> (),
                      onError: () -> ()) {
        var allValid = true
        
        validations.forEach {
            let valid = $0.value.validationBlock()
            $0.value.validatedBlock($0.key, valid)
            if allValid { allValid = valid }
        }
        
        allValid ? onSuccess() : onError()
    }
}
