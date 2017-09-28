//
//  ProfileTextFieldCell.swift
//  Hamp
//
//  Created by Aleix Baggerman on 26/9/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class ProfileTextFieldCell: UITableViewCell {
    
    var info: ProfileTextFieldInfo? {
        didSet {
            captionLabel.text = info?.captionTitle
            textField.textField.text = info?.textFieldText
        }
    }
    
    private var captionLabel: UILabel = {
        let label = UILabel ()
        label.font = UIFont.helveticaBold(withSize: 20)
        label.text = "Nombre"
        return label
    } ()
    
    private var textField: ProfileTextField = {
        let tf = ProfileTextField ()
        tf.contentMode = .redraw
        return tf
    } ()
    
    override func draw(_ rect: CGRect) {
        contentView.addSubview(captionLabel)
        contentView.addSubview(textField)
        
        captionLabel.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, paddingTop: 5, paddingLeft: 20, paddingBottom: 0, paddingRight: 72, width: 0, height: 24)
        textField.anchor(top: captionLabel.bottomAnchor, left: captionLabel.leftAnchor, bottom: nil, right: captionLabel.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)
        
    }
    
}
