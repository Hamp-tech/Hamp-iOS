//
//  UserDetailTableViewController.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 31/3/18.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class UserDetailTableViewController: HampTableViewController {

	// MARK: - Properties
	private let provider = UserDetailDataProvider()
	private let cellConfigurator = UserDetailCellConfigurator()
	
	// MARK: - Life cycle
	init() {
		super.init(style: .grouped)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		title = "Detalles personales"
		tableView.register(UserDetailTextFieldCell.nib, forCellReuseIdentifier: UserDetailTextFieldCell.reuseIdentifier)
		tableView.tableFooterView = UIView()
		
		tableView.rowHeight = 44
    }
}

extension UserDetailTableViewController {
	// MARK: - Table view data source
	override func numberOfSections(in tableView: UITableView) -> Int {
		return provider.numberOfSections()
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return provider.numberOfRows(at: section)
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: UserDetailTextFieldCell.reuseIdentifier, for: indexPath) as! UserDetailTextFieldCell
		
		let content = provider.content(at: indexPath)
		cellConfigurator.configure(cell: cell, content: content)

		return cell
	}
}
