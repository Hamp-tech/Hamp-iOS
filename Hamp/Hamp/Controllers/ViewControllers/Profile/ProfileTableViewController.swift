//
//  ProfileTableViewController.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 27/3/18.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class ProfileTableViewController: HampTableViewController {

	// MARK: - Properties
	private let provider = ProfileDataProvider()
	private lazy var navigator: Navigator = {
		return Navigator(rootViewController: self)
	}()
	
	// MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
		
		tableView.register(ProfileTableViewCell.nib, forCellReuseIdentifier: ProfileTableViewCell.reuseIdentifier)
		tableView.tableFooterView = tableFooterView()
		
		tableView.rowHeight = 44
		
		navigationController?.navigationBar.tintColor = .darkPink
    }
}

extension ProfileTableViewController {
	
	// MARK: - Table view data source
	override func numberOfSections(in tableView: UITableView) -> Int {
		return provider.numberOfSections()
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return provider.numberOfRows(at: section)
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.reuseIdentifier, for: indexPath)
		
		let content = provider.content(at: indexPath)
		cell.textLabel?.text = content.title
		cell.accessoryType = content.navigation != nil ? .disclosureIndicator : .none
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return provider.title(at: section)
	}
}

extension ProfileTableViewController {
	// MARK: - Table view delegate
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard let nav = provider.content(at: indexPath).navigation else { return }
		
		navigator.navigate(navigation: nav)
	}
}

private extension ProfileTableViewController {
	func tableFooterView() -> UIView {
		let b = UIButton(type: .roundedRect)
		b.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50)
		b.setTitle("Cerrar sesión", for: .normal)
		b.setTitleColor(.red, for: .normal)
		b.backgroundColor = .white
		b.titleLabel?.textAlignment = .center
		
		return b
	}
}
