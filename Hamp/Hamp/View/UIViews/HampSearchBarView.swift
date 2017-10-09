//
//  HampSearchBarView.swift
//  Hamp
//
//  Created by Aleix Baggerman on 7/10/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class HampSearchBarView: UIView {
    
    lazy var searchBarView: UISearchBar = {
        let sbv = UISearchBar ()
        sbv.placeholder = "Ciudad, calle, codigo postal..."
        sbv.delegate = self
        return sbv
    } ()
    
    override func draw(_ rect: CGRect) {
        addSubview(searchBarView)
        searchBarView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 0)
    }
    
}

extension HampSearchBarView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}
