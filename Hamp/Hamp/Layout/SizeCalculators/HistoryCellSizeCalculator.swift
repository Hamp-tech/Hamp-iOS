//
//  HistoryCellSizeCalculator.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 12/9/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation
import HampKit

struct HistoryCellSizeCalculator {
    
    var topMargin: CGFloat
    var bottomMargin: CGFloat
    
    func height(by booking: HampBooking) -> CGFloat {
        return topMargin + 89 + bottomMargin
    }
}
