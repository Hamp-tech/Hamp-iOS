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
    
    func addCreditCard (creditCard: CreditCard, onSucced: @escaping () -> Void, onError: @escaping (_ message: String)->Void) {
        Hamp.Users.createCard(userID: Hamp.Auth.user!.identifier!, card: creditCard) { (response) in
            if response.code == .ok {
                onSucced ()
            } else {
                onError (response.message)
                print("ERROR ADDING CREDIT CARD TO USER", response.message)
            }
        }
    }
    
    func getCreditCardAt (index: Int) -> CreditCard? {
        return Hamp.Auth.user!.cards?[index]
    }

    func deleteCreditCardAt (index: Int, onSucced: @escaping () -> Void) {
        guard let creditCardID = Hamp.Auth.user!.cards?[index].identifier else {return}
        print(creditCardID)
        Hamp.Users.deleteCard(userID: Hamp.Auth.user!.identifier!, cardID: creditCardID) { (response) in
            if response.code == .ok {
                onSucced()
            } else {
                print("ERROR DELETING CREDIT CARD TO USER", response.message)
            }
        }
    }
    
    func fetchCreditCards() -> [CreditCard] {
        return Hamp.Auth.user?.cards ?? []
    }
    
    func numberOfCreditCards () -> Int {
        return fetchCreditCards().count
    }
}


