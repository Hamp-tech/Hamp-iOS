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

class ServicesOrderCollectionViewCell: ReusableCollectionViewCell {

    //MARK: IB Properties
    @IBOutlet weak private var amountLabel: UILabel!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var priceLabel: UILabel!
    
    //MARK: Properties
    var orderableService: OrderableService!
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
        nameLabel.text = orderableService.service.name
        needsUpdateUI()
    }
    
    @IBAction func addWasPressed(_ sender: UIButton) {
        delegate?.addWasPressed(on: self, service: orderableService.service)
    }
    
    @IBAction func removeWasPressed(_ sender: UIButton) {
        delegate?.removeWasPressed(on: self, service: orderableService.service)
    }
}

extension ServicesOrderCollectionViewCell {
    //MARK: Public
    func needsUpdateUI() {
        amountLabel.text = String.init(orderableService.service.amount)
        priceLabel.text = "\(orderableService.service.amount*orderableService.service.price) €"
        active = orderableService.service.amount > 0
    }
}

private extension ServicesOrderCollectionViewCell {
    //MARK: Private
    func reloadViewsColor() {
        amountLabel.textColor = active ? textActiveColor : inactiveColor
        nameLabel.textColor = active ? textActiveColor : inactiveColor
        priceLabel.textColor = active ? complementaryViewsActiveColor : inactiveColor
    }
}
