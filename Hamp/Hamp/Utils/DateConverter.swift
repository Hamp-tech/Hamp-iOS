//
//  DateConverter.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 13/9/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation

struct DateConverter {
    static func getHistoryDateFormatFromISO8601(iso8601Date: String) -> String {
        let formatter = DateFormatter.init()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        let date = formatter.date(from: iso8601Date)
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: date!)
    }
}
