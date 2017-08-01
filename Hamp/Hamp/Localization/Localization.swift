//
//  LocalizationManager.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 1/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation

public class Localization {
    /// Localized string by key
    ///
    /// - Parameter key: localized key
    /// - Returns: localized stringa
    static func localizableString(by key: String) -> String {
        return NSLocalizedString(key,
                                 tableName: nil,
                                 bundle: Bundle.main,
                                 value: "",
                                 comment: "")
    }
}
