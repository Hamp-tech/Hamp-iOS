//
//  HistoryTransactionDetailViewController.swift
//  Hamp
//
//  Created by Aleix Baggerman on 24/03/2018.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class HistoryTransactionDetailViewController: HampTableViewController {

	// MARK: - Properties
	private var mapViewController: MapController!
    private var contentProvider: HistoryDetailTableViewProvider!
	private var transaction: DBTransaction!
	private var configurator = HistoryTransactionDetailCellConfigurator()
	
	// MARK: - Life cycle
    init (transaction: DBTransaction) {
        super.init(style: .grouped)
		self.transaction = transaction
        contentProvider = HistoryDetailCellsProvider.init(transaction: transaction)
        mapViewController = MapController (point: transaction.booking!.point!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        tableView.register(HistoryTransactionDetailTableViewCell.nib, forCellReuseIdentifier: HistoryTransactionDetailTableViewCell.reuseIdentifier)
		tableView.tableHeaderView = setupTableHeaderView()
    }
}

extension HistoryTransactionDetailViewController {
	// MARK: - Data source
	override func numberOfSections(in tableView: UITableView) -> Int {
        return contentProvider.numberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentProvider.numberOfRowsInSection(section: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTransactionDetailTableViewCell.reuseIdentifier, for: indexPath)
		
		configurator.configure(cell: cell, content: contentProvider.contentWith(indexPath: indexPath))
		
		return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return contentProvider.getSectionTitle(section: section)
    }
}

private extension HistoryTransactionDetailViewController {
	func setupTableHeaderView() -> UIView {
		let mapController = HistoryTransactionDetailMapController(point: transaction.booking!.point!)
		mapController.view.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 300)
		mapController.willMove(toParentViewController: self)
		mapController.didMove(toParentViewController: self)
		return mapController.view
		
	}
}
