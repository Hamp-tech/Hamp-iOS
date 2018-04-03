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
	private var editedValues = [String: Any]()
	
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
	
	func shouldBecomeFirstResponder(on cell: UserDetailTextFieldCell) -> Bool{
		let indexPath = tableView.indexPath(for: cell)!
		let content = provider.content(at: indexPath)
		
		guard let input = content.input, (input == .date || input == .gender)  else {
			return true
		}
		
		return false
		
	}
	
	func needsToBeRespondered(on cell: UserDetailTextFieldCell) {
		
		let indexPath = tableView.indexPath(for: cell)!
		let content = provider.content(at: indexPath)
		
		if let input = content.input, (input == .date || input == .gender) {
			_ = lastCellWithResponder?.resignFirstResponder()
			presentPicker(by: input, with: cell)
		}
	}
	
	func valueDidChange(on cell: UserDetailTextFieldCell, value: Any?) {
		let indexPath = tableView.indexPath(for: cell)!
		let content = provider.content(at: indexPath)
		content.value = value as? String
		content.isEdited = true
		validator.validation(cell: cell, content: content) { valid in
			cell.titleLabel.textColor = valid ? .black : .red
		}
	}
}

private extension UserDetailTableViewController {
	@objc func editWasPressed(sender: UIBarButtonItem) {
		
		_ = lastCellWithResponder?.resignFirstResponder()
		
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
	
	func presentPicker(by input: ProfileCellContent.Input, with cell: UserDetailTextFieldCell) {
		switch input {
		case .date:
			presentDatePicker(with: cell)
		case .gender:
			presentGender(with: cell)
		default:
			break
		}
	}
	
	func presentDatePicker(with cell: UserDetailTextFieldCell) {
		DPPickerManager.shared.showPicker(title: "Cumpleaños", picker: { (picker) in
			picker.date = Date()
			picker.datePickerMode = .date
		}) { [unowned self] (date, cancel) in
			if !cancel {
				cell.textField.text = DateFormatter.localizedString(from: date!, dateStyle: .short, timeStyle: .none)
			}
		}
	}
	
	func presentGender(with cell: UserDetailTextFieldCell) {
		let values = ["Hombre", "Mujer", "--"]
		DPPickerManager.shared.showPicker(title: "Género", selected: "Hombre", strings: values) { (value, index, cancel) in
			if !cancel {
				cell.textField.text = value
			}
		}
	}
}

