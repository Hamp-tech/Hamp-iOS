//
//  ServicesOrderCollectionViewCell.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 17/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class ServicesOrderCollectionViewCell: UICollectionViewCell {

    //MARK: IB Properties
    @IBOutlet weak private var amountLabel: UILabel!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var priceLabel: UILabel!
    
    //MARK: Properties
    var separator: UIView!
    var service: Service!
    var color: UIColor {
        return service.amount > 0 ? .darkPink : .lightGray
    }

    //MARK: Life cycle
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupSecondaryViews()
        amountLabel.text = String.init(service.amount)
        nameLabel.text = service.name
        priceLabel.text = "\(service.amount*service.price)€"
    }
    
    @IBAction func addWasPressed(_ sender: UIButton) {
    
    }
    
    @IBAction func removeWasPressed(_ sender: UIButton) {
    
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
        
        separator = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 10, height: bounds.height))
        separator.backgroundColor = color
        separator.layer.masksToBounds = true
        auxiliarViewToShowLeftSeparator.addSubview(separator)
    }
    
    
    func reloadViewsColor() {
        amountLabel.textColor = color
        nameLabel.textColor = color
        priceLabel.textColor = color
        separator.backgroundColor = color
    }
}
