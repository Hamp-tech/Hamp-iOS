//
//  HistoryTableViewCell.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 21/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell, Reusable {

    
    //MARK: Properties
    @IBOutlet weak var labelView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    //MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupLeftSeparator()
    }
}

private extension HistoryTableViewCell {
    //MARK: Private
    func setupLeftSeparator() {
        let auxiliarViewToShowLeftSeparator = UIView.init(frame: labelView.bounds)
        auxiliarViewToShowLeftSeparator.cornerRadius = 9
        auxiliarViewToShowLeftSeparator.backgroundColor = .white
        auxiliarViewToShowLeftSeparator.layer.masksToBounds = true
        labelView.insertSubview(auxiliarViewToShowLeftSeparator, at: 0)
        
        let separator = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 10, height: labelView.bounds.height))
        separator.backgroundColor = UIColor.darkPink
        separator.layer.masksToBounds = true
        auxiliarViewToShowLeftSeparator.addSubview(separator)
    }
}
