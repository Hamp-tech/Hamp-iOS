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
    @IBOutlet private weak var servicesOrderedLabel: UILabel!
    
    //MARK: Properties
    var service: OrderableService!
    weak var delegate: ServicesCollectionViewCellDelegate?
    
    //MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        serviceImageView.image = UIImage.init(named: service.imageName)
        titleLabel.text = service.name
        servicesOrderedLabel.text = String.init(service.amount)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        serviceImageView.image = nil
        servicesOrderedLabel.text = "0"
        titleLabel.text = nil
    }
    
    //MARK: Actions
    @IBAction func addWasPressed(_ sender: UIButton) {
        delegate?.addWasPressed(on: self, order: service)
    }
    
    @IBAction func removeWasPressed(_ sender: UIButton) {
        delegate?.removeWasPressed(on: self, order: service)
    }
}

extension ServicesCollectionViewCell {
    func updateAmountLabel() {
       updateAmountLabel(with: String.init(service.amount))
    }
    
    private func updateAmountLabel(with text: String) {
        servicesOrderedLabel.text = text
    }
}
