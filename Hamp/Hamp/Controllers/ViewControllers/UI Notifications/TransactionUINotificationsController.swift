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
	@IBOutlet private weak var notificationBottomConstraint: NSLayoutConstraint!
	
	// MARK: - Properties
	var transaction: HampKit.Transaction!
	var configurator = TransactionsUINotificationCellConfigurator()
	
	// MARK: - Life cycle
	init(transaction: Transaction) {
		super.init(nibName: nil, bundle: nil)
		self.transaction = transaction
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
		
		tableView.register(TransactionsUINotificationsTableViewCell.nib, forCellReuseIdentifier: TransactionsUINotificationsTableViewCell.reuseIdentifier)
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
	
	func present(completion: (() -> Void)? = nil) {
		let last = notificationBottomConstraint.constant
		
		notificationBottomConstraint.constant = -view.frame.height
		view.layoutIfNeeded()
		notificationBottomConstraint.constant = last
		
		UIView.animate(withDuration: 0.5, animations: { [unowned self] in
			self.view.layoutIfNeeded()
		}) { (finished) in
			completion?()
		}
	}
	
	func dismiss(completion: (() -> Void)? = nil) {
		notificationBottomConstraint.constant = -view.frame.height
		
		UIView.animate(withDuration: 0.3, animations: { [unowned self] in
			self.view.layoutIfNeeded()
		}) { (finished) in
			completion?()
		}
	}
}

extension TransactionUINotificationsController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return transaction.booking?.pickUpLockers?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: TransactionsUINotificationsTableViewCell.reuseIdentifier, for: indexPath) as! TransactionsUINotificationsTableViewCell
		let locker = transaction.booking!.pickUpLockers![indexPath.row]
		configurator.configure(cell: cell, values: ("\(locker.number!)", locker.code!))
		
		return cell
	}
	
	
}


