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
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Editar", style: .plain, target: self, action: #selector(editWasPressed(sender:)))
		
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
extension UserDetailTableViewController {
	// MARK: - Table view delegate
	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return false
	}
}

private extension UserDetailTableViewController {
	@objc func editWasPressed(sender: UIBarButtonItem) {
		isEditing = !isEditing
		tableView.visibleCells.forEach{ $0.isEditing = isEditing }
		
		if isEditing {
			let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! UserDetailTextFieldCell
			cell.textField.becomeFirstResponder()
			sender.title = "Guardar"
		} else {
			sender.title = "Editar"
		}
	}
}
