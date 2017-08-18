//
//  ServicesOrderCollectionViewCell.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 17/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class ServicesOrderCollectionViewCell: UICollectionViewCell {

    //MARK: Properties
    var service: Service!
    
    //MARK: Life cycle
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupSecondaryViews()
    }
}

extension ServicesOrderCollectionViewCell: Reusable { }

private extension ServicesOrderCollectionViewCell {
    //MARK: Private
    func setupSecondaryViews() {
        let auxiliarViewToShowLeftSeparator = UIView.init(frame: bounds)
        auxiliarViewToShowLeftSeparator.cornerRadius = 9
        auxiliarViewToShowLeftSeparator.backgroundColor = .white
        auxiliarViewToShowLeftSeparator.layer.masksToBounds = true
        contentView.insertSubview(auxiliarViewToShowLeftSeparator, at: 0)
        
        let separator = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 10, height: bounds.height))
        separator.backgroundColor = UIColor.darkPink
        separator.layer.masksToBounds = true
        auxiliarViewToShowLeftSeparator.addSubview(separator)
    }
}
