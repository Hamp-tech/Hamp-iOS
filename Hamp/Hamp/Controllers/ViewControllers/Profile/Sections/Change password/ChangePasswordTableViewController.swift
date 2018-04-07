//
//  ChangePasswordTableViewController.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 6/4/18.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class ChangePasswordTableViewController: HampTableViewController {
	
	// MARK: - Properties
	private var titles = [
		"Contraseña actual",
		"Nueva contraseña",
		"Repetir contraseña"
	]
	
	// MARK: - Life cycle
	init() {
		super.init(style: .grouped)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		title = "Cambiar contraseña"
		tableView.register(UserDetailTextFieldCell.nib, forCellReuseIdentifier: UserDetailTextFieldCell.reuseIdentifier)
		tableView.footer = false
		tableView.rowHeight = 44
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Guardar", style: .plain, target: self, action: #selector(saveWasPressed(_:)))
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		let cell = tableView.cellForRow(at: IndexPath(item: 0, section: 0))
		cell?.becomeFirstResponder()
	}
}

extension ChangePasswordTableViewController {
	// MARK: - Table view data source
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return titles.count
	}
	
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: UserDetailTextFieldCell.reuseIdentifier, for: indexPath) as! UserDetailTextFieldCell
		cell.titleLabel.text = titles[indexPath.row]
		cell.textField.isSecureTextEntry = true
		return cell
	}
}

private extension ChangePasswordTableViewController {
	@objc func saveWasPressed(_ sender: UIBarButtonItem) {
		let texts = tableView.visibleCells.map { (cell) -> String in
			return (cell as! UserDetailTextFieldCell).textField.text!
		}
		
		let validTexts = texts.map{$0.count > 0}.reduce(true, {$0 && $1})
		
		guard validTexts else {
			// TODO: Show alert
			return
		}
		
		guard texts[1] == texts[2] else {
			// TODO: Show alert
			return
		}
		
		
		print("Ok")
	}
}
