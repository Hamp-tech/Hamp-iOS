//
//  ProfileDateCell.swift
//  Hamp
//
//  Created by Aleix Baggerman on 26/9/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class ProfileDateCell: ProfileCell {
    
    override var content: UserContent? {
        didSet {
            captionLabel.text = content?.labelText
            dateTextField.text = content?.textFieldText
        }
    }
    
    private var captionLabel: UILabel = {
        let label = UILabel ()
        label.font = UIFont.helveticaBold(withSize: 20)
        label.text = "Fecha de nacimiento"
        return label
    } ()
    
    private let dateTextField: UITextField = {
        let tf = UITextField ()
        tf.backgroundColor = .white
        tf.borderStyle = .roundedRect
        tf.textColor = UIColor.init(red: 155/255, green: 155/255, blue: 155/255, alpha: 1)
        return tf
    } ()
    
    override func draw(_ rect: CGRect) {
        contentView.addSubview(captionLabel)
        contentView.addSubview(dateTextField)
        
        captionLabel.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, paddingTop: 5, paddingLeft: 20, paddingBottom: 0, paddingRight: 72, width: 0, height: 24)
        dateTextField.anchor(top: captionLabel.bottomAnchor, left: captionLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 186, height: 37)
    }
    
}
