//
//  StoreTableViewCell.swift
//  Hamp
//
//  Created by Aleix Baggerman on 6/10/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class StoreTableViewCell: UITableViewCell {

    let locationNameLabel: UILabel = {
        let label = UILabel ()
        label.font = UIFont.helveticaBold(withSize: 20)
        label.backgroundColor = .red
        label.textAlignment = .left
        return label
    } ()
    
//    let starImageView: UIImageView = {
//        let imageView = UIImageView ()
//        imageView.backgroundColor = .pink
//        return imageView
//    } ()
    
    let streetLabel: UILabel = {
        let label = UILabel ()
        label.font = UIFont.helvetica(withSize: 16)
        label.backgroundColor = .green
        label.textAlignment = .left
        return label
    } ()
    
//    let distanceLabel = UILabel = {
//        let label = UILabel ()
//        label.font = UIFont.hel
//    } ()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
