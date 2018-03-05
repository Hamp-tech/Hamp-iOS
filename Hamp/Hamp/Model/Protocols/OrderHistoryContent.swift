//
//  OrderHistoryCell.swift
//  Hamp
//
//  Created by Aleix Baggerman on 05/03/2018.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import Foundation
import HampKit

protocol OrderHistoryContent {
    var identifier: String! {get set}
    var title: String? {get set}
    var images: [UIImage]? {get set}
    var lockers: [DBLocker]? {get set}
    var services: [LaundryService]? {get set}
    var time: Booking.PickUpTime? {get set}
    var creditCardNumber: String? {get set}
}
