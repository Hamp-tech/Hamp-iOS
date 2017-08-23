//
//  ClosedRange+Clamp.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 22/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation

extension ClosedRange {
    func clamp(_ value: Bound) -> Bound {
        return self.lowerBound > value ? self.lowerBound
            : self.upperBound < value ? self.upperBound
            : value
    }
}
