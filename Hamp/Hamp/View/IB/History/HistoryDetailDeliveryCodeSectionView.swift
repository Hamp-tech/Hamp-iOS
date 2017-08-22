//
//  HistoryDetailDeliveryCodeSectionView.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 22/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class HistoryDetailDeliveryCodeSectionView: HistoryDetailSectionView {

    //MARK: Properties
    private var lockerView: LockerView!
    
    //MARK: Life cycle
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupLockerView()
    }
}

private extension HistoryDetailDeliveryCodeSectionView {
    //MARK: Private
    func setupLockerView() {
        lockerView = LockerView.init()
        lockerView.translatesAutoresizingMaskIntoConstraints = false
//        lockerView.backgroundColor = UIColor.green
        contentView.addSubview(lockerView)
        
        NSLayoutConstraint.activate([
            lockerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            lockerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            lockerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            lockerView.widthAnchor.constraint(equalToConstant: 40)
            ])
    }
}
