//
//  HistoryTableViewController.swift
//  Hamp
//
//  Created by Aleix Baggerman on 05/04/2018.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class HistoryTableViewController: HampTableViewController {
    
    //MARK: Properties
	private var historyDataProvider = ProvidersManager.sharedInstance.historyProvider
	private var transactions = [DBTransaction]()
	
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerReusableCell(HistoryTableViewCell.self)
        tableView.separatorStyle = .none
		tableView.rowHeight = 170
		tableView.footer = false
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		historyDataProvider.getData { [weak self] (results) in
			self?.transactions = results.map{$0 as! DBTransaction}.reversed()
			self?.tableView.reloadData()
		}
	}
}

//MARK: TableView data source
extension HistoryTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeReusableCell(indexPath: indexPath) as HistoryTableViewCell
		
        return cell
    }
}
