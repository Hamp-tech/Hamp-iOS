//
//  StoreTableViewCell.swift
//  Hamp
//
//  Created by Aleix Baggerman on 6/10/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class StoreTableViewCell: UITableViewCell {

    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!
    
    var distance: Float? {
        didSet {
            let distanceText = String.init(format: "%.2f", distance ?? 0)
            distanceLabel.text = distanceText + " km"
        }
    }
    
    var locationName: String? {
        didSet {
            locationNameLabel.text = locationName
        }
    }
}
