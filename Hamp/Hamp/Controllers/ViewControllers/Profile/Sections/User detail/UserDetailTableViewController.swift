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
		guard isEditing else { return false }
		
		let indexPath = tableView.indexPath(for: cell)!
		let content = provider.content(at: indexPath)
		
		guard let input = content.input, (input == .date || input == .gender)  else {
			return true
		}
		
		return false
		
	}
	
	func needsToBeRespondered(on cell: UserDetailTextFieldCell) {
		guard isEditing else { return }
		
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
		validator.validation(cell: cell, content: content) { [weak self] valid in
			cell.titleLabel.textColor = valid ? .black : .red
			if valid {
				self?.updateEditedValues(cell: cell, value: cell.textField.text!)
			}
		}
	}
}

private extension UserDetailTableViewController {
	@objc func editWasPressed(sender: UIBarButtonItem) {
		
		_ = lastCellWithResponder?.resignFirstResponder()
		
		if !isEditing {
			changeState(to: true)
			
			let cell = tableView.visibleCells.first as? UserDetailTextFieldCell
			cell?.textField.becomeFirstResponder()
			
		} else {
			guard editedValues.count > 0 else {
				changeState(to: false)
				return
			}
			
			validator.validate(
				onSuccess: {
					let user = try! JSONDecoder().decode(User.self, from: JSONSerialization.data(withJSONObject: self.editedValues, options: .prettyPrinted))
					user.identifier = Hamp.Auth.user?.identifier
					
					Hamp.Users.update(user: user, onResponse: { (response) in
						if response.code == .ok {
							DispatchQueue.main.async { [unowned self] in
								self.changeState(to: false)
								self.provider.reload()
								self.tableView.reloadData()
								self.lastCellWithResponder = nil
							}
						} else {
							// TODO: Show alert
							print(response.code)
						}
					})
			}, onError: {
				lastCellWithResponder?.isEditing = true
				_ = lastCellWithResponder?.becomeFirstResponder()
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
				cell.textField.text = DateConverter.convertDateToString(date: date!)
				let iso8601 = date!.iso8601()
				self.updateEditedValues(cell: cell, value: iso8601)
			}
		}
	}
	
	func presentGender(with cell: UserDetailTextFieldCell) {
		let values = Gender.rawValues
		DPPickerManager.shared.showPicker(title: "Género", selected: "Hombre", strings: values) { (value, index, cancel) in
			if !cancel {
				cell.textField.text = value
				let gender = Gender.all[index]
				self.updateEditedValues(cell: cell, value: gender.code())
				
			}
		}
	}
	
	func updateEditedValues(cell: UserDetailTextFieldCell, value: Any) {
		let content = provider.content(at: tableView.indexPath(for: cell)!)
		editedValues[content.jsonKey!] = value
	}
	
	func changeState(to editing: Bool) {
		isEditing = editing
		tableView.visibleCells.forEach{ $0.isEditing = editing }
		navigationItem.rightBarButtonItem?.title = editing ? "Guardar" : "Editar"
	}
}

