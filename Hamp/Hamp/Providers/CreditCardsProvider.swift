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
    
    private let user: User
    
    init() {
        user = Hamp.Auth.user!
    }
    
    func addCreditCard (creditCard: CreditCard) {
        Hamp.Users.createCard(userID: user.identifier!, card: creditCard) { (response) in
            if response.code != .ok {
                print("ERROR ADDING CREDIT CARD TO USER", response.message)
            }
        }
    }
    
    func getCreditCardAt (index: Int) -> CreditCard? {
        return user.cards?[index]
    }

    func deleteCreditCardAt (index: Int) {
        guard let creditCardID = user.cards?[index].identifier else {return}
        Hamp.Users.deleteCard(userID: user.identifier!, cardID: creditCardID) { (response) in
            if response.code != .ok {
                print("ERROR DELETING CREDIT CARD TO USER", response.message)
            }
        }
    }
    
    func fetchCreditCards() -> [CreditCard] {
        return user.cards ?? []
    }
    
    func numberOfCreditCards () -> Int {
        return user.cards?.count ?? 0
    }
}


