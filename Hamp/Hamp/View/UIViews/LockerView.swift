//
//  LockerView.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 22/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class LockerView: UIView {
    //MARK: Properties
    var number: Int = 0
    private var lockerImageView: UIImageView!
    private var numberLabel: UILabel!
    
    //MARK: Life cycle
    override func updateConstraints() {
        super.updateConstraints()
        setupLockerImageView()
        setupNumberLabel()
    }
}

private extension LockerView {
    //MARK: Private
    func setupLockerImageView() {
        lockerImageView = UIImageView.init(image: #imageLiteral(resourceName: "locker"))
        lockerImageView.contentMode = .scaleAspectFit
        lockerImageView.tintColor = .black
        lockerImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(lockerImageView)
        
        NSLayoutConstraint.activate([
            lockerImageView.leftAnchor.constraint(equalTo: leftAnchor),
            lockerImageView.topAnchor.constraint(equalTo: topAnchor),
            lockerImageView.rightAnchor.constraint(equalTo: rightAnchor),
            lockerImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    
    func setupNumberLabel() {
        numberLabel = UILabel.init()
        numberLabel.text = String.init(number)
        numberLabel.numberOfLines = 1
        numberLabel.minimumScaleFactor = 0.4
        numberLabel.adjustsFontSizeToFitWidth = true
        numberLabel.textAlignment = .center
        numberLabel.textColor = .darkPink
        numberLabel.font = UIFont.fredoka(withSize: 15)
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(numberLabel)
        
        NSLayoutConstraint.activate([
            numberLabel.leftAnchor.constraint(equalTo: lockerImageView.leftAnchor),
            numberLabel.rightAnchor.constraint(equalTo: lockerImageView.rightAnchor),
            numberLabel.centerYAnchor.constraint(equalTo: lockerImageView.centerYAnchor, constant: -2)
            ])
        
    }
}
