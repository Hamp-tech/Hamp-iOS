//
//  ServicesOrderCollectionViewCell.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 17/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

protocol ServicesOrderCellDelegate: class {
    func addWasPressed(on cell: ServicesOrderCollectionViewCell, service: Service)
    func removeWasPressed(on cell: ServicesOrderCollectionViewCell, service: Service)
}

class ServicesOrderCollectionViewCell: UICollectionViewCell {

    //MARK: IB Properties
    @IBOutlet weak private var amountLabel: UILabel!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var priceLabel: UILabel!
    
    //MARK: Properties
    var separator: UIView!
    var service: Service!
    var active = true {
        didSet(newValue) {
            if active != newValue { reloadViewsColor() }
        }
    }
    weak var delegate: ServicesOrderCellDelegate?
    let inactiveColor = UIColor.lightGray
    let textActiveColor = UIColor.black
    let complementaryViewsActiveColor = UIColor.darkPink

    //MARK: Life cycle
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupSecondaryViews()
        nameLabel.text = service.name
        needsUpdateUI()
    }
    
    @IBAction func addWasPressed(_ sender: UIButton) {
        delegate?.addWasPressed(on: self, service: service)
    }
    
    @IBAction func removeWasPressed(_ sender: UIButton) {
        delegate?.removeWasPressed(on: self, service: service)
    }
}

extension ServicesOrderCollectionViewCell: Reusable { }

extension ServicesOrderCollectionViewCell {
    //MARK: Public
    func needsUpdateUI() {
        amountLabel.text = String.init(service.amount)
        priceLabel.text = "\(service.amount*service.price)€"
        active = service.amount > 0
    }
}

private extension ServicesOrderCollectionViewCell {
    //MARK: Private
    func setupSecondaryViews() {
        let auxiliarViewToShowLeftSeparator = UIView.init(frame: bounds)
        auxiliarViewToShowLeftSeparator.cornerRadius = 9
        auxiliarViewToShowLeftSeparator.backgroundColor = .white
        auxiliarViewToShowLeftSeparator.layer.masksToBounds = true
        contentView.insertSubview(auxiliarViewToShowLeftSeparator, at: 0)
        
        separator = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 10, height: bounds.height))
        separator.backgroundColor = complementaryViewsActiveColor
        separator.layer.masksToBounds = true
        auxiliarViewToShowLeftSeparator.addSubview(separator)
    }
    
    
    func reloadViewsColor() {
        amountLabel.textColor = active ? textActiveColor : inactiveColor
        nameLabel.textColor = active ? textActiveColor : inactiveColor
        priceLabel.textColor = active ? complementaryViewsActiveColor : inactiveColor
        separator.backgroundColor = active ? complementaryViewsActiveColor : inactiveColor
    }
}
