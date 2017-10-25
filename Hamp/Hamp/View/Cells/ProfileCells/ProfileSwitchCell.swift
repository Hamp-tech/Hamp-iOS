//
//  ProfileSwitchCell.swift
//  Hamp
//
//  Created by Aleix Baggerman on 26/9/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class ProfileSwitchCell: ProfileCell {
    
    override var content: UserContent? {
        didSet {
            guard let content = content else {return}
            captionLabel.text = content.labelText
            switchView.isOn = content.firstOption == .rightOption
        }
    }
    
    private var captionLabel: UILabel = {
        let label = UILabel ()
        label.font = UIFont.helveticaBold(withSize: 20)
        label.text = "Recogida"
        return label
    } ()
    
    private lazy var switchView: UISwitch = {
        let sv = UISwitch ()
        sv.tintColor = UIColor.darkPink
        sv.addTarget(self, action: #selector (handleOptionSelection), for: .valueChanged)
        sv.onTintColor = UIColor.darkPink
        return sv
    } ()
    
    override func draw(_ rect: CGRect) {
        contentView.addSubview(switchView)
        contentView.addSubview(captionLabel)
        
        switchView.anchor(top: nil, left: nil, bottom: nil, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 36, width: 39, height: 23)
        switchView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        captionLabel.anchor(top: nil, left: contentView.leftAnchor, bottom: nil, right: switchView.leftAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 25, width: 0, height: 24)
        captionLabel.centerYAnchor.constraint (equalTo: contentView.centerYAnchor).isActive = true
    }

    @objc func handleOptionSelection () {
        print (switchView.isOn)
    }
    
}
