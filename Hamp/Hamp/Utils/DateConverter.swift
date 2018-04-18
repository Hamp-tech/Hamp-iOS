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
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        let date = formatter.date(from: iso8601Date)
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: date!)
    }
    
    static func getDateFromString (iso8601Date: String) -> Date? {
        let dateFormatter = DateFormatter ()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return dateFormatter.date(from: iso8601Date)
    }
    
    static func convertDateToString (date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    static func getMaxDateFromYear (year: Int) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.date(from: String(year) + "/01/01") ?? Date ()
    }
    
    static func getActualYear () -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY"
        let year = dateFormatter.string(from: Date())
        return Int(year) ?? 0
    }
    
    static func getMonthStringBy (month: Int) -> String {
        guard month > 0 && month <= 12 else {return "Incorrect Month"}
        let months = ["Gener", "Febrer", "Març", "Abril", "Maig", "Juny", "Juliol", "Agost", "Setembre", "Octubre", "Novembre", "Decembre"]
        return months[month - 1]
    }
    
    static func convertDateToLongString (date: Date) -> String {
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        
        let dateString = String(day) + " de " + getMonthStringBy(month: month) + " del " + String(year)
        
        return dateString
    }

}
