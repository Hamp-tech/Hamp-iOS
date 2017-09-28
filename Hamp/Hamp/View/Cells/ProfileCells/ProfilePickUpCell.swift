//
//  ProfilePickUpCell.swift
//  Hamp
//
//  Created by Aleix Baggerman on 26/9/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class ProfilePickUpCell: UITableViewCell {
    
    var captionLabel: UILabel = {
        let label = UILabel ()
        label.font = UIFont.helveticaBold(withSize: 20)
        label.text = "Fecha de nacimiento"
        return label
    } ()
    
    lazy var timeTablePicker: UISegmentedControl = {
        let segmentedControll = UISegmentedControl (items: ["Mañana", "Tarde"])
        segmentedControll.tintColor = UIColor.darkPink
        segmentedControll.addTarget(self, action: #selector (handleTimeSelector), for: .valueChanged)
        return segmentedControll
    } ()
    
    override func draw(_ rect: CGRect) {
        contentView.addSubview(captionLabel)
        contentView.addSubview(timeTablePicker)
        
        captionLabel.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, paddingTop: 5, paddingLeft: 20, paddingBottom: 0, paddingRight: 72, width: 0, height: 24)
        timeTablePicker.anchor(top: captionLabel.bottomAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 24)
    }
    
    @objc func handleTimeSelector () {
        print (timeTablePicker.selectedSegmentIndex)
    }
}
