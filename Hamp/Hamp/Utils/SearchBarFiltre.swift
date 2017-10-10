//
//  SearchBarFiltre.swift
//  Hamp
//
//  Created by Aleix Baggerman on 7/10/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation

struct SearchBarFiltre {
    
    static var filteredSearchElements = [HampPoint] ()
    
    static func filterSearch (searchText: String, searchElements: [HampPoint]) {
        if searchText.characters.isEmpty {
            filteredSearchElements = searchElements
        } else {
            self.filteredSearchElements = filteredSearchElements.filter({ (hampPoint) -> Bool in
                return didContainsElements(hampPoint: hampPoint, searchText: searchText)
            })
        }
    }
    
    private static func didContainsElements (hampPoint: HampPoint, searchText: String) -> Bool {
        let calle = hampPoint.identifier
        let ciudad = hampPoint.name
        let codigoPostal = hampPoint.postalCode
        
        return calle.lowercased().contains(searchText.lowercased()) || ciudad.lowercased().contains(searchText.lowercased()) ||
            codigoPostal.lowercased().contains(searchText.lowercased())
    }
}
