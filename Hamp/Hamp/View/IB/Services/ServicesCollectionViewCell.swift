//
//  ServicesCollectionViewCell.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 16/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class ServicesCollectionViewCell: UICollectionViewCell, Reusable {

    //MARK: IB Properties
    @IBOutlet private weak var serviceImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var servicesOrderedLabel: UILabel!
    
    //MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: Actions
    
    @IBAction func addWasPressed(_ sender: UIButton) {
    
    }
    
    @IBAction func removeWasPressed(_ sender: UIButton) {
    
    }
}
