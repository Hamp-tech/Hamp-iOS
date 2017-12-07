//
//  ServicesCollectionViewCell.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 16/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

protocol ServicesCollectionViewCellDelegate: class {
    func addWasPressed(on cell: ServicesCollectionViewCell, orderableService: OrderableService)
    func removeWasPressed(on cell: ServicesCollectionViewCell, orderableService: OrderableService)
}

class ServicesCollectionViewCell: ReusableCollectionViewCell {

    //MARK: IB Properties
    @IBOutlet private weak var serviceImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var amountSelectionView: AmountSelectionView!
    
    //MARK: Properties
    var orderableService: OrderableService! {
        didSet {
            serviceImageView.image = UIImage.init(named: orderableService.imageName)
            titleLabel.text = orderableService.service.name
            amountSelectionView.updateAmount(with: orderableService.service.amount)
        }
    }
    weak var delegate: ServicesCollectionViewCellDelegate?
    
    //MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        amountSelectionView.delegate = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        serviceImageView.image = nil
        titleLabel.text = nil
        amountSelectionView.updateAmount(with: 0)
    }
}

extension ServicesCollectionViewCell {
    func needsUpdateUI() {
       amountSelectionView.updateAmount(with: orderableService.service.amount)
    }
}

extension ServicesCollectionViewCell: AmountSelectionViewDelegate {
    func removeWasPressed(on view: AmountSelectionView) {
        delegate?.removeWasPressed(on: self, orderableService: orderableService)
    }
    
    func addWasPressed(on view: AmountSelectionView) {
        delegate?.addWasPressed(on: self, orderableService: orderableService)
    }
    
    func initialAmount() -> Int {
        return orderableService.service.amount
    }
}
