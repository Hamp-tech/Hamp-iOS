//
//  ProfileUseInfoCell.swift
//  Hamp
//
//  Created by Aleix Baggerman on 26/9/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class ProfileUseInfoCell: UITableViewCell {
    
    var clickImageView: UIImageView = {
        let imageView = UIImageView ()
        imageView.backgroundColor = UIColor.darkPink
        return imageView
    } ()
    
    lazy var conditionsButton: UIButton = {
        let button = UIButton (type: .system)
        let attributedText = NSMutableAttributedString (string: "Ver ", attributes: [NSAttributedStringKey.foregroundColor: UIColor.init(red: 155/255, green: 155/255, blue: 155/255, alpha: 1), NSAttributedStringKey.font: UIFont.helvetica(withSize: 14)])
        attributedText.append(createUnderlinedAttributedString(text: "condiciones"))
        attributedText.append(createSimpleAttributedString(text: " de uso."))
        button.setAttributedTitle(attributedText, for: .normal)
        button.addTarget(self, action: #selector (handleConditions), for: .touchUpInside)
        return button
    } ()
    
    override func draw(_ rect: CGRect) {
        contentView.addSubview(conditionsButton)
        contentView.addSubview(clickImageView)
        
        conditionsButton.anchor(top: contentView.topAnchor, left: nil, bottom: contentView.bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 0, paddingBottom: 5, paddingRight: 0, width: 200, height: 0)
        conditionsButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        clickImageView.anchor(top: nil, left: nil, bottom: nil, right: conditionsButton.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 5, width: 14, height: 18.4)
        clickImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    @objc func handleConditions () {
        print ("Conditions")
    }
    
    private func createUnderlinedAttributedString (text: String) -> NSAttributedString {
        return NSAttributedString (string: text, attributes: [NSAttributedStringKey.foregroundColor: UIColor.init(red: 155/255, green: 155/255, blue: 155/255, alpha: 1), NSAttributedStringKey.font: UIFont.helvetica(withSize: 14), NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
    }
    
    private func createSimpleAttributedString (text: String) -> NSAttributedString {
        return NSAttributedString (string: text, attributes: [NSAttributedStringKey.foregroundColor: UIColor.init(red: 155/255, green: 155/255, blue: 155/255, alpha: 1), NSAttributedStringKey.font: UIFont.helvetica(withSize: 14)])
    }
}
