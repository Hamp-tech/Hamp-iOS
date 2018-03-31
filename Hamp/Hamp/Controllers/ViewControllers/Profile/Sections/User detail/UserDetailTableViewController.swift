//
//  UserDetailTableViewController.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 31/3/18.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import UIKit
import HampKit

class UserDetailTableViewController: HampTableViewController {
	
	// MARK: - Properties
	private let cellConfigurator = UserDetailCellConfigurator()
	private var provider = UserDetailDataProvider()
	private var validator = UserDetailCellValidator()
	private var lastCellWithResponder: UserDetailTextFieldCell?
	
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
		cell.delegate = self
		
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


extension UserDetailTableViewController: UserDetailTextFieldCellDelegate {
	func becameFirstResponder(on cell: UserDetailTextFieldCell) {
		lastCellWithResponder = cell
	}
	
	func valueDidChange(on cell: UserDetailTextFieldCell, value: Any?) {
		let indexPath = tableView.indexPath(for: cell)!
		let content = provider.content(at: indexPath)
		content.value = value as? String
		content.isEdited = true
		validator.validation(cell: cell, content: content)
	}
}

private extension UserDetailTableViewController {
	@objc func editWasPressed(sender: UIBarButtonItem) {
		
		lastCellWithResponder?.resignFirstResponder()
		
		if !isEditing {
			
			isEditing = true
			tableView.visibleCells.forEach{ $0.isEditing = true }
			
			let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! UserDetailTextFieldCell
			cell.textField.becomeFirstResponder()
			sender.title = "Guardar"
		} else {
			tableView.visibleCells.forEach{ $0.isEditing = false }
			validator.validate(
				onSuccess: {
					var dict = [String: Any]()
					provider.modifiedContents().forEach{ dict[$0.jsonKey!] = $0.value! }
					
					let user = try! JSONDecoder().decode(User.self, from: JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted))
					user.identifier = Hamp.Auth.user?.identifier
					
					Hamp.Users.update(user: user, onResponse: { (response) in
						if response.code == .ok {
							DispatchQueue.main.async { [unowned self] in
								sender.title = "Editar"
								self.provider.reload()
								self.tableView.reloadData()
								self.isEditing = false
								self.lastCellWithResponder = nil
								
							}
						} else {
							print(response.code)
						}
					})
			}, onError: {
				tableView.visibleCells.forEach{ $0.isEditing = true }
				lastCellWithResponder?.isEditing = true
				lastCellWithResponder?.becomeFirstResponder()
			})
		}
	}
}

