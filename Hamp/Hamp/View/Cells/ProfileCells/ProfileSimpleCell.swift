//
//  ProfileSimpleCell.swift
//  Hamp
//
//  Created by Aleix Baggerman on 26/9/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class ProfileSimpleCell: UITableViewCell {
    
    var captionButton: UIButton = {
        let button = UIButton (type: .system)
        let attributedText = NSAttributedString (string: "Cerrar sesión", attributes: [NSAttributedStringKey.font:UIFont.helveticaBold(withSize: 20)])
        button.setAttributedTitle(attributedText, for: .normal)
        button.tintColor = .black
        return button
    } ()
    
    override func draw(_ rect: CGRect) {
        contentView.addSubview(captionButton)
        
        captionButton.anchor(top: nil, left: contentView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 128, height: 24)
        captionButton.centerYAnchor.constraint (equalTo: contentView.centerYAnchor).isActive = true
    }
    
}
