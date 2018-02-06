//
//  CreditCardsProvider.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 21/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation
import HampKit

class CreditCardsProvider {
    //MARK: Properties
    static var creditCards: [HampCreditCard] = {
       return fetchCreditCards()
    }()
    
    static func deleteCreditCardAt (index: Int) {
        creditCards.remove(at: index)
    }
}

private extension CreditCardsProvider {
    static func fetchCreditCards() -> [HampCreditCard] {
        var cards = [HampCreditCard]()
        cards.append(try! HampCreditCard.init(identifier: "123456789", number: "4242424242424242", name: "Joan Molinas Ramon", month: "12", year: "21", cvv: "123"))
        return cards
    }
}
