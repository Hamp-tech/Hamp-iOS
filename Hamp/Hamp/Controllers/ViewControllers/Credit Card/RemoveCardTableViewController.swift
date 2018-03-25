//
//  RemoveCardTableViewController.swift
//  Hamp
//
//  Created by Aleix Baggerman on 31/01/2018.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import UIKit
import HampKit

class RemoveCardTableViewController: HampTableViewController {
    
    private let cardCellID = "CreditCardTableViewCell"
    private var creditCardProvider: CreditCardsProvider = CreditCardsProvider()
    
    override func viewDidLoad() {
        self.title = "Cards"
        self.navigationItem.rightBarButtonItem = nil
        self.navigationController?.navigationBar.tintColor = .darkPink
        registerCells ()
    }
    
    func registerCells () {
        let nib = UINib (nibName: cardCellID, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cardCellID)
    }
    
    //MARK: TableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creditCardProvider.numberOfCreditCards()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cardCellID, for: indexPath) as! CreditCardTableViewCell
        cell.creditCard = creditCardProvider.getCreditCardAt(index: indexPath.row)!
        cell.selectionStyle = .none
        return cell
    }
    
    //MARK: TableViewDelegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            creditCardProvider.deleteCreditCardAt(index: indexPath.row, onSucced: { [unowned self] in
                DispatchQueue.main.async {
                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
                }
            })
        }
    }
}
