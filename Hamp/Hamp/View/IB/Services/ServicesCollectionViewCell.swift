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
    
    //MARK: Properties
    var order: OrderableService!
    
    //MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        serviceImageView.image = UIImage.init(named: order.imageName)
        titleLabel.text = order.name
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        serviceImageView.image = nil
    }
    
    //MARK: Actions
    
    @IBAction func addWasPressed(_ sender: UIButton) {
    
    }
    
    @IBAction func removeWasPressed(_ sender: UIButton) {
    
    }
}
