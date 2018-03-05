//
//  DescriptionImageCell.swift
//  Hamp
//
//  Created by Aleix Baggerman on 27/9/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class DescriptionImageCell: UICollectionViewCell {
    
    var image: UIImage? {
        didSet {
            guard let image = image else {return}
            imageView.image = image
        }
    }
    
    var numberOfItems: Int? = 0 {
        didSet {
            guard let numberOfItems = numberOfItems else {return}
            roundedLabel.text = String (describing: numberOfItems)
        }
    }
    
    private let imageView: UIImageView = {
        let iv = UIImageView ()
        iv.backgroundColor = UIColor.white
        iv.contentMode = .center
        return iv
    } ()
    
    private let roundedLabel: BasketRoundLabel = {
        let label = BasketRoundLabel ()
        label.text = "1"
        return label
    } ()
    
    private let roundedLabelContainerView: UIView = {
        let view = UIView ()
        view.backgroundColor = .white
        return view
    } ()
    
    let roundedViewWidth:CGFloat = 30
    
    override func draw(_ rect: CGRect) {
        contentView.addSubview(imageView)
        contentView.addSubview(roundedLabelContainerView)
        roundedLabelContainerView.addSubview(roundedLabel)
        
        imageView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        roundedLabelContainerView.anchor(top: nil, left: nil, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: roundedViewWidth, height: roundedViewWidth)
        roundedLabel.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: roundedViewWidth * 0.9, height: roundedViewWidth * 0.9)
        roundedLabel.centerXAnchor.constraint(equalTo: roundedLabelContainerView.centerXAnchor).isActive = true
        roundedLabel.centerYAnchor.constraint(equalTo: roundedLabelContainerView.centerYAnchor).isActive = true
        roundedLabelContainerView.layer.cornerRadius = roundedViewWidth/2
        roundedLabelContainerView.clipsToBounds = true
    }
    
}
