//
//  NewHistoryTableViewCell.swift
//  Hamp
//
//  Created by Aleix Baggerman on 05/04/2018.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class NewHistoryTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var servicesStackView: UIStackView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    //MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.clipsToBounds = true
        servicesStackView.distribution = .fillEqually
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        servicesStackView = UIStackView()
    }
    
    //MARK: Prepare data
    
    func setStackViewImages (images: [UIImage]) {
        images.forEach { (image) in
            let imageView = UIImageView(image: image)
            servicesStackView.addArrangedSubview(imageView)
        }
    }
}










