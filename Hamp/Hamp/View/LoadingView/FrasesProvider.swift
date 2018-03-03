//
//  FrasesProvider.swift
//  LoadingScreen
//
//  Created by Aleix Baggerman on 14/11/2017.
//  Copyright © 2017 Aleix Baggerman. All rights reserved.
//

import Foundation

struct FrasesProvider {
    static let frases = ["Curiosidad numero uno", "Soy un murcielago muy veloz", "Hola que tal"]
    
    private static var lastIndex = 0
    
    static func getRandomFrase () -> String {
        var randomIndex = Int(arc4random_uniform(UInt32(frases.count)))
        if randomIndex == lastIndex {
            if randomIndex < frases.count - 1 {
                randomIndex = randomIndex + 1
            } else if randomIndex == frases.count - 1 {
                randomIndex = randomIndex - 1
            }
        }
        lastIndex = randomIndex
        return frases[randomIndex]
    }
}
