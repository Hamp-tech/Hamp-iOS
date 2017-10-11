//
//  HampSearchBarView.swift
//  Hamp
//
//  Created by Aleix Baggerman on 7/10/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class HampSearchBarView: UIView {
    
    var delegate: HampSearchBarDelegate!
    var initialSearchElements: [HampPoint]? {
        didSet {
            guard let initialSearchElements = initialSearchElements else {return}
            SearchBarFiltre.filteredSearchElements = initialSearchElements
        }
    }
    
    lazy var searchTextField: ProfileTextField = {
        let tf = ProfileTextField ()
        tf.textField.placeholder = "Ciudad, calle, codigo postal..."
        tf.textField.addTarget(self, action: #selector (textFieldDidChange), for: .editingChanged)
        tf.contentMode = .redraw
        tf.textField.returnKeyType = .search
        return tf
    } ()
    
    override func draw(_ rect: CGRect) {
        addSubview(searchTextField)
        searchTextField.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
    }
    
    @objc func textFieldDidChange () {
        guard let initialSearchElements = self.initialSearchElements else {return}
        SearchBarFiltre.filterSearch(searchText: searchTextField.textField.text ?? "", searchElements: initialSearchElements)
        delegate.searchBarDidUpdateSearchElements(elements: SearchBarFiltre.filteredSearchElements)
    }
    
}
