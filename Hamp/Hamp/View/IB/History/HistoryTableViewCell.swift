//
//  HistoryTableViewCell.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 21/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit
import HampKit

class HistoryTableViewCell: UITableViewCell, Reusable {

    
    // MARK: - IB Properties
    @IBOutlet private weak var labelView: UIView!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var servicesHiredStackView: UIStackView!
    
    // MARK: - Properties
    var booking: HampBooking!
    
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        dateLabel.text = DateConverter.getHistoryDateFormatFromISO8601(iso8601Date: booking.transaction!.date!)
        priceLabel.text = "\(Int.init(booking.transaction!.payment!))€"
        
        setupLeftSeparator()
        createServicesHiredSubviews()
    }
}

private extension HistoryTableViewCell {
    // MARK: - Private
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
    
    func createServicesHiredSubviews() {
        guard let order = booking.transaction?.order else { return }
        order.servicesHired().forEach {
            let label = stackServicesDefaultLabel()
            label.text = "\($0)"
            servicesHiredStackView.addArrangedSubview(label)
        }
    }
    
    func stackServicesDefaultLabel() -> UILabel {
        let label = UILabel.init()
        label.textColor = UIColor.lightGray
        return label
    }
}
