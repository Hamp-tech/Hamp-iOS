//
//  ProfileSignOutCell.swift
//  Hamp
//
//  Created by Aleix Baggerman on 26/9/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit
import HampKit

class ProfileSignOutCell: ProfileCell {
    
    override var content: UserContent? {
        didSet {
            guard let content = content else {return}
            self.captionButton.setTitle(content.labelText, for: .normal)
        }
    }
    
    private lazy var captionButton: UIButton = {
        let button = UIButton (type: .system)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont.helveticaBold(withSize: 20)
        button.tintColor = .black
        button.addTarget(self, action: #selector (cerrarSession), for: .touchUpInside)
        return button
    } ()
    
    override func draw(_ rect: CGRect) {
        contentView.addSubview(captionButton)
        
        captionButton.anchor(top: nil, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 24)
        captionButton.centerYAnchor.constraint (equalTo: contentView.centerYAnchor).isActive = true
    }
    
    @objc func cerrarSession () {
        content?.actionBlock?()
    }
    
}
