//
//  ProfileGenderCell.swift
//  Hamp
//
//  Created by Aleix Baggerman on 26/9/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class ProfileGenderCell: ProfileCell {

    override var content: UserContent? {
        didSet {
            guard let content = content else {return}
            firstOptionLabel.text = content.firstOptionText
            secondOptionLabel.text = content.secondOptionText
            firstCheckBoxButton.isSelected = content.firstOption == .leftOption
            secondCheckBoxButton.isSelected = content.firstOption == .rightOption
        }
    }
    
    override var isEnabled: Bool? {
        didSet {
            let enabled = isEnabled ?? true
            firstCheckBoxButton.isUserInteractionEnabled = enabled
            secondCheckBoxButton.isUserInteractionEnabled = enabled
        }
    }
    
    private var firstOptionLabel: UILabel = {
        let label = UILabel ()
        label.font = UIFont.helveticaBold(withSize: 20)
        label.text = "Hombre"
        return label
    } ()
    
    private var secondOptionLabel: UILabel = {
        let label = UILabel ()
        label.font = UIFont.helveticaBold(withSize: 20)
        label.text = "Mujer"
        return label
    } ()
    
    private lazy var firstCheckBoxButton: CheckBoxButton = {
        let button = CheckBoxButton ()
        button.contentMode = .redraw
        button.addTarget(self, action: #selector (handleFirstChecking (sender:)), for: .touchDown)
        return button
    } ()
    
    private lazy var secondCheckBoxButton: CheckBoxButton = {
        let button = CheckBoxButton ()
        button.contentMode = .redraw
        button.addTarget(self, action: #selector (handleSecondChecking (sender:)), for: .touchUpInside)
        return button
    } ()
    
    override func draw(_ rect: CGRect) {
        contentView.addSubview(firstOptionLabel)
        contentView.addSubview(firstCheckBoxButton)
        contentView.addSubview(secondOptionLabel)
        contentView.addSubview(secondCheckBoxButton)
    
        let firstLabelWidth = firstOptionLabel.intrinsicContentSize.width
        let secondLabelWidth = secondOptionLabel.intrinsicContentSize.width
        let buttonWidth:CGFloat = 21
        
        firstOptionLabel.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 20, paddingBottom: 5, paddingRight: 0, width: firstLabelWidth, height: 0)
        firstCheckBoxButton.anchor(top: nil, left: firstOptionLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: buttonWidth, height: buttonWidth)
        firstCheckBoxButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        secondOptionLabel.anchor(top: firstOptionLabel.topAnchor, left: firstCheckBoxButton.rightAnchor, bottom: firstOptionLabel.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 25, paddingBottom: 0, paddingRight: 0, width: secondLabelWidth, height: 0)
        secondCheckBoxButton.anchor(top: firstCheckBoxButton.topAnchor, left: secondOptionLabel.rightAnchor, bottom: firstCheckBoxButton.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: buttonWidth, height: 0)
    
    }
    
    @objc func handleFirstChecking (sender: CheckBoxButton) {
        firstCheckBoxButton.isSelected = !firstCheckBoxButton.isSelected
        secondCheckBoxButton.isSelected = false
    }
    
    @objc func handleSecondChecking (sender: CheckBoxButton) {
        secondCheckBoxButton.isSelected = !secondCheckBoxButton.isSelected
        firstCheckBoxButton.isSelected = false
    }
    

    
}

