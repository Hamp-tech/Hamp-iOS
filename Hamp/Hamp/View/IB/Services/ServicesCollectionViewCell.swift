//
//  ServicesCollectionViewCell.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 16/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

protocol ServicesCollectionViewCellDelegate: class {
    func addWasPressed(on cell: ServicesCollectionViewCell, order: OrderableService)
    func removeWasPressed(on cell: ServicesCollectionViewCell, order: OrderableService)
}

class ServicesCollectionViewCell: UICollectionViewCell, Reusable {

    //MARK: IB Properties
    @IBOutlet private weak var serviceImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var amountSelectionView: AmountSelectionView!
    
    //MARK: Properties
    var service: OrderableService!
    weak var delegate: ServicesCollectionViewCellDelegate?
    
    //MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        amountSelectionView.delegate = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        serviceImageView.image = UIImage.init(named: service.imageName)
        titleLabel.text = service.name
        amountSelectionView.updateAmount(with: service.service.amount)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        serviceImageView.image = nil
        titleLabel.text = nil
        amountSelectionView.updateAmount(with: 0)
    }
}

extension ServicesCollectionViewCell {
    func updateAmountLabel() {
       amountSelectionView.updateAmount(with: service.service.amount)
    }
}

extension ServicesCollectionViewCell: AmountSelectionViewDelegate {
    func removeWasPressed(on view: AmountSelectionView) {
        delegate?.removeWasPressed(on: self, order: service)
    }
    
    func addWasPressed(on view: AmountSelectionView) {
        delegate?.addWasPressed(on: self, order: service)
    }
    
    func initialAmount() -> Int {
        return service.service.amount
    }
    
    
}
