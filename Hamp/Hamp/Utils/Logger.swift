//
//  Logger.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 12/3/18.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import Foundation

struct Logger {
	static func d(_ message: Any,
				  event: Event = .d,
				  fileName: String = #file,
				  line: Int = #line,
				  column: Int = #column,
				  function: String = #function,
				  inAnExternalFile: Bool = true) {
		let log = "\(event.rawValue)[\(DateConverter.convertDateToString(date: Date()))] \(sourceFileName(filePath: fileName)).\(function):\(line) => \(message)"
		print(log)
		
		if inAnExternalFile {
			
		}
	}
}

extension Logger {
	enum Event: String{
		case e = "[‼️]" // error
		case i = "[ℹ️]" // info
		case d = "[💬]" // debug
		case v = "[🔬]" // verbose
		case w = "[⚠️]" // warning
		case s = "[🔥]" // severe
	}
}

private extension Logger {
	static func sourceFileName(filePath: String) -> String {
		let components = filePath.components(separatedBy: "/")
		return components.isEmpty ? "" : (components.last?.components(separatedBy: ".").first!)!
	}
}
