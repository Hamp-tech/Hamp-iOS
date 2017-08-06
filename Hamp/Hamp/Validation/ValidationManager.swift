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
//    private var validations = [String: Validation]()
    private var validations = NSMapTable<NSString, Validation>.init(keyOptions: NSPointerFunctions.Options.strongMemory, valueOptions: NSPointerFunctions.Options.weakMemory)
    
    //MARK: Public
    public mutating func add(by validation: Validation) {
        self.validations.setObject(validation, forKey: validation.key as NSString)
    }
    
    public func validate(onSuccess: () -> (),
                         onError: () -> ()) {
        var allValid = true
        
        let enumerator = validations.objectEnumerator()
        
        while let value: Validation = enumerator?.nextObject() as? Validation  {
            let valid = value.validationBlock()
            value.validatedBlock(value.key, valid)
            if allValid { allValid = valid }
        }
        
        allValid ? onSuccess() : onError()
    }
    
    public func check(onSuccess: () -> (),
                      onError: () -> ()) {
        var allValid = true
        
        let enumerator = validations.objectEnumerator()
        
        while let value: Validation = enumerator?.nextObject() as? Validation  {
            let valid = value.validationBlock()
            if allValid { allValid = valid }
        }
        
        allValid ? onSuccess() : onError()
    }
}
