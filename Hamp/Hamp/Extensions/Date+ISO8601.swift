//
//  Date+ISO8601.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 3/4/18.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import Foundation

extension Date {
	private static let iso8601Formatter: DateFormatter = {
		var dateFormatter = DateFormatter()
		dateFormatter.locale = Locale(identifier: "en_US_POSIX")
		dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
		return dateFormatter
	}()
	
	func iso8601() -> String {
		return Date.iso8601Formatter.string(from: self)
	}
}
