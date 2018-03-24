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
	@IBOutlet private weak var locationLabel: UILabel!
	@IBOutlet private weak var descriptionLabel: UILabel!
	@IBOutlet private weak var tableView: UITableView!
	@IBOutlet private weak var notificationHeightConstraint: NSLayoutConstraint!
	@IBOutlet private weak var notificationBottomConstraint: NSLayoutConstraint!
	
	// MARK: - Properties
	private var transactionId: String!
	private var header: String!
	private var subtitle: String!
	private var lockers: [Locker]!
	private var configurator = TransactionsUINotificationCellConfigurator()
	
	// MARK: - Life cycle
	init(transactionId: String, header: String, subtitle: String, lockers: [Locker]) {
		super.init(nibName: nil, bundle: nil)
		self.transactionId = transactionId
		self.header = header
		self.subtitle = subtitle
		self.lockers = lockers
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
		
		locationLabel.text = header
		
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
		return lockers.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: TransactionsUINotificationsTableViewCell.reuseIdentifier, for: indexPath) as! TransactionsUINotificationsTableViewCell
		let locker = lockers[indexPath.row]
		configurator.configure(cell: cell, values: ("\(locker.number!)", locker.code!))
		
		return cell
	}
	
	
}


