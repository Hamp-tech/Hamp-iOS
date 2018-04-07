//
//  HistoryCellConfigurator.swift
//  Hamp
//
//  Created by Aleix Baggerman on 05/04/2018.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import UIKit

struct HistoryCellConfigurator {
    func configurate (cell: HistoryTableViewCell, content: DBTransaction) {
        cell.titleLabel.text = content.booking?.point?.location?.name
		cell.priceLabel.text = String(content.booking!.price) + " €"
		let wasDelivered = content.deliveryDate.count > 0
		
		cell.detailLabel.text = wasDelivered ? "Listo para recoger" : "Lavándose"
//		let services = content.booking!.services.flatMap{$0}.prefix(3)
		cell.headerView.backgroundColor = wasDelivered ? .superLightPink : .lightGray
    }
}
