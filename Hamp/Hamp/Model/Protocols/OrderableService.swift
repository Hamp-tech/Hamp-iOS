//
//  OrderableService.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 16/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation

protocol OrderableService {
    var service: Service { get set }
    var imageName: String { get set }
    var name: String { get set }
    
}
