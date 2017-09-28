//
//  CheckBoxButton.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 7/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class CheckBoxButton: UIButton {
    
    //MARK: Properties
    private let selectedColor = UIColor.ligthPink
    private let deselectedColor = UIColor.white
    
    //MARK: Life cycle
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        self.tintColor = UIColor.clear
//        self.setBackgroundImage(UIImage.from(color: selectedColor), for: .selected)
//        self.setBackgroundImage(UIImage.from(color: deselectedColor), for: .normal)
//    }
    
    override func updateConstraints() {
        self.tintColor = UIColor.clear
        self.setBackgroundImage(UIImage.from(color: selectedColor), for: .selected)
        self.setBackgroundImage(UIImage.from(color: deselectedColor), for: .normal)
        
        super.updateConstraints()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        roundCorners()
        setupBorders()
    }
}

private extension CheckBoxButton {
    //MARK: Private
    func setupBorders(){
        self.layer.borderColor = UIColor.darkPink.cgColor
        self.layer.borderWidth = 1.5
        
    }
}

