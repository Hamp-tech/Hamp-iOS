//
//  SearchBarFiltre.swift
//  Hamp
//
//  Created by Aleix Baggerman on 7/10/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation

struct Tienda {
    var calle = ""
    var ciudad = ""
    var codigoPostal = ""
}

struct SearchBarFiltre {
    
    static var filteredSearchElements = [Tienda] ()
    
    static func filterSearch (searchText: String, searchElements: [Tienda]) {
        if searchText.characters.isEmpty {
            filteredSearchElements = searchElements
        } else {
            
            self.filteredSearchElements = filteredSearchElements.filter({ (tienda) -> Bool in
                return didContainsElements(tienda: tienda, searchText: searchText)
            })
        }
    }
    
    private static func didContainsElements (tienda: Tienda, searchText: String) -> Bool {
        let calle = tienda.calle
        let ciudad = tienda.ciudad
        let codigoPostal = tienda.codigoPostal
        
        return calle.lowercased().contains(searchText.lowercased()) || ciudad.lowercased().contains(searchText.lowercased()) ||
            codigoPostal.lowercased().contains(searchText.lowercased())
    }
}
