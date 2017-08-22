//
//  FirstTimeActionsManager.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 14/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

public struct FirstTimeActionsManager {
    static func needsExecuteAction(by action: Action) -> Bool {
        let ud = UserDefaults.standard
        let executeNextTime = ud.value(forKey: action.rawValue) == nil || ud.bool(forKey: action.rawValue)
        return executeNextTime
    }
    
    static func changeFirstTimeState(to action: Action, executeNextTime: Bool) {
        let ud = UserDefaults.standard
        ud.set(executeNextTime, forKey: action.rawValue)
        ud.synchronize()
    }
}

extension FirstTimeActionsManager {
    enum Action {
        case presentNewCreditCard
        case presentTutorial
        
        var rawValue: String {
            switch self {
            case .presentNewCreditCard:
                return presentNewCreditCardViewControllerOnFirstTime
            case .presentTutorial:
                return presentTutorialOnFirstTime
            }
        }
    }
}

