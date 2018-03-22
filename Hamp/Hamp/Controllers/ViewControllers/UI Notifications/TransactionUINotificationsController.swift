//
//  TransactionUINotificationsController.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 21/3/18.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import UIKit
import HampKit

class TransactionUINotificationsController: HampViewController {
	
	// MARK: - IBProperties
	@IBOutlet private weak var tableView: UITableView!
	@IBOutlet private weak var notificationHeightConstraint: NSLayoutConstraint!
	
	// MARK: - Properties
	var transaction: HampKit.Transaction!
	
	// MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
		modalPresentationStyle = .overCurrentContext
		
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TransactionsUINotificationCell")
		tableView.rowHeight = 60
    }
	
	override func updateViewConstraints() {
		tableView.layoutIfNeeded()
		notificationHeightConstraint.constant = min(200 + tableView.contentSize.height, view.frame.height - 150)
		super.updateViewConstraints()
	}
}


extension TransactionUINotificationsController: UINotificable {
	func notification() -> UIView {
		return view
	}
}

extension TransactionUINotificationsController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 3
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionsUINotificationCell", for: indexPath)
		return cell
	}
	
	
}


