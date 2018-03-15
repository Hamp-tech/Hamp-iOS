//
//  DataProvider.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 12/9/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation
import RealmSwift

protocol DataProvider {
    func download()
    func getData (onResponse: @escaping (Results<Object>)->())
    func getDataWith (index: Int, onResponse: @escaping (Object)->())
}
