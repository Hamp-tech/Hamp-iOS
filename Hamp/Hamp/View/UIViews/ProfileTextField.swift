//
//  ProfileTextField.swift
//  Hamp
//
//  Created by Aleix Baggerman on 26/9/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class ProfileTextField: UIView {
    
    let textField: UITextField = {
        let tf = UITextField ()
        tf.backgroundColor = .clear
        tf.font = UIFont.helvetica(withSize: 16)
        return tf
    } ()
    
    let separatorLine: UIView = {
        let view = UIView ()
        view.backgroundColor = UIColor.init(red: 151/255, green: 151/255, blue: 151/255, alpha: 1)
        return view
    } ()
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        self.textField.delegate = self
        self.backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        addSubview(separatorLine)
        addSubview(textField)
        
        separatorLine.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1.5)
        textField.anchor(top: nil, left: leftAnchor, bottom: separatorLine.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 22, paddingBottom: 1, paddingRight: 0, width: 0, height: 22)
    }
}

extension ProfileTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
}


