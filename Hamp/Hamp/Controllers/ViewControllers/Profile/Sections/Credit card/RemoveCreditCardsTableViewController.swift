//
//  RemoveCreditCardsTableViewController.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 5/4/18.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import UIKit
import HampKit

class RemoveCreditCardsTableViewController: HampTableViewController {
	
	// MARK: - Properties
	private var cards: [CreditCard] {
		return Hamp.Auth.user?.cards ?? []
	}
	
	// MARK: - Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Métodos de pago"
		
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
		tableView.footer = false
	}
}

extension RemoveCreditCardsTableViewController {
	// MARK: - Table view data source
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return cards.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier, for: indexPath)
		let card = cards[indexPath.row]
		cell.textLabel?.text = "Visa acabada en " + card.number!
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	// Override to support editing the table view.
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

		guard let id = Hamp.Auth.user?.identifier, let cid = cards[indexPath.row].identifier else { return }
		Hamp.Users.deleteCard(userID: id, cardID: cid) { (response) in
			if response.code == .ok {
				DispatchQueue.main.async { [unowned self] in
					self.tableView.deleteRows(at: [indexPath], with: .fade)
				}
			} else {
				// TODO: Show alert
			}
		}
	}
}

