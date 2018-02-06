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
    private var staticLabelsHeight: CGFloat = 35
    private var stackViewTopMargin: CGFloat = 11
    private var stackViewBottomMargin: CGFloat = 11
    private var stackViewElementHeight: CGFloat = 24
    
    
    init(topMargin: CGFloat, bottomMargin: CGFloat) {
        self.topMargin = topMargin
        self.bottomMargin = bottomMargin
    }
    
    func height(by booking: HampBooking) -> CGFloat {
        let servicesHired = booking.transaction?.order?.basket.count ?? 0
        let orderServicesSizeAmount = stackViewElementHeight*CGFloat.init(servicesHired)
        return topMargin + staticLabelsHeight + stackViewTopMargin + orderServicesSizeAmount + stackViewBottomMargin + bottomMargin
    }
}
