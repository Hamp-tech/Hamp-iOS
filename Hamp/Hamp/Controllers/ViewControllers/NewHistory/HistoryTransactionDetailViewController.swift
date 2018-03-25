//
//  HistoryTransactionDetailViewController.swift
//  Hamp
//
//  Created by Aleix Baggerman on 24/03/2018.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class HistoryTransactionDetailViewController: HampTableViewController {

    let historyCellID = "HistoryCellID"

    var mapViewController: MapController!
    var contentProvider: HistoryDetailTableViewProvider!
    
    init (transaction: DBTransaction) {
        super.init(style: .grouped)
        contentProvider = HistoryDetailCellsProvider.init(transaction: transaction)
        mapViewController = MapController (point: transaction.booking!.point!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}

extension HistoryTransactionDetailViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return contentProvider.numberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentProvider.numberOfRowsInSection(section: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "reuseIdentifier")
        }
        let content = contentProvider.contentWith(indexPath: indexPath)

        cell!.textLabel?.text = content.title
        cell!.detailTextLabel?.text = content.detail
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return contentProvider.getSectionTitle(section: section)
    }
    
    
}
