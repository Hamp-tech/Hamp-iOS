//
//  OrderInfoCell.swift
//  Hamp
//
//  Created by Aleix Baggerman on 27/9/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class OrderInfoCell: UICollectionViewCell {
    
    let doorImageView: UIImageView = {
        let imageView = UIImageView ()
        imageView.image = #imageLiteral(resourceName: "locker").withRenderingMode(.alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
        return imageView
    } ()
    
    let padlockImageView: UIImageView = {
        let imageView = UIImageView ()
        imageView.image = #imageLiteral(resourceName: "locker").withRenderingMode(.alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
        return imageView
    } ()
    
    let clockImageView: UIImageView = {
        let imageView = UIImageView ()
        imageView.image = #imageLiteral(resourceName: "clock-empty").withRenderingMode(.alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
        return imageView
    } ()
    
    var title: String? {
        didSet {
            captionLabel.text = title
        }
    }
    
    var infoText: [String]? {
        didSet {
            doorLabel.text = infoText? [0] ?? "?"
            padlockLabel.text = infoText? [1] ?? "?"
            clockLabel.text = infoText? [2] ?? "?"
        }
    }
    
    private let captionLabel: UILabel = {
        let label = UILabel ()
        label.font = UIFont.helveticaBold(withSize: 20)
        label.text = "Descripción"
        return label
    } ()
    
    private let separationView: UIView = {
        let view = UIView ()
        view.backgroundColor = UIColor.init(red: 151/255, green: 151/255, blue: 151/255, alpha: 1)
        return view
    } ()
    
    private let doorLabel: UILabel = {
        let label = UILabel ()
        label.font = UIFont.helvetica(withSize: 18)
        label.text = "?"
        return label
    } ()
    
    private let padlockLabel: UILabel = {
        let label = UILabel ()
        label.font = UIFont.helvetica(withSize: 18)
        label.text = "?"
        return label
    } ()
    
    private let clockLabel: UILabel = {
        let label = UILabel ()
        label.font = UIFont.helvetica(withSize: 18)
        label.text = "?"
        return label
    } ()
    
    let imagesWidth:CGFloat = 25
    let imagesHeight:CGFloat = 30
    let imagesPadding:CGFloat = 10
    
    override func draw(_ rect: CGRect) {
        let imagesStackView = UIStackView (arrangedSubviews: [doorImageView, padlockImageView, clockImageView])
        let labelsStackView = UIStackView (arrangedSubviews: [doorLabel, padlockLabel, clockLabel])

        contentView.addSubview (captionLabel)
        contentView.addSubview (separationView)
        contentView.addSubview(imagesStackView)
        contentView.addSubview(labelsStackView)

        imagesStackView.axis = .vertical
        imagesStackView.distribution = .fillEqually
        imagesStackView.spacing = imagesPadding
        
        labelsStackView.axis = .vertical
        labelsStackView.distribution = .fillEqually
        labelsStackView.spacing = imagesPadding
        
        captionLabel.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 53, width: 0, height: 24)
        separationView.anchor(top: captionLabel.bottomAnchor, left: captionLabel.leftAnchor, bottom: nil, right: captionLabel.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1.5)
        imagesStackView.anchor(top: separationView.topAnchor, left: separationView.leftAnchor, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: imagesWidth, height: 3 * imagesHeight + 2 * imagesPadding)
        labelsStackView.anchor(top: imagesStackView.topAnchor, left: imagesStackView.rightAnchor, bottom: imagesStackView.bottomAnchor, right: separationView.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 5, width: 0, height: 0)
    }
    
}
