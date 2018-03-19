//
//  DynamicTableViewController.swift
//  DynamicTableViewController
//
//  Created by Joan Molinas Ramon on 26/8/17.
//  Copyright © 2017 Joan Molinas Ramon. All rights reserved.
//

import UIKit

class DynamicTableViewController: UITableViewController {

    public var dataSource: DynamicDataSource! {
        didSet {
            precondition(dataSource != nil, "DynamicDataSource cannot be nil")
            tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let _ = dataSource else { return 0 }
        return dataSource.numberOfSections()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.numberOfRows(in: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")
        cell!.contentView.backgroundColor = dataSource.row(atSection: indexPath.section, rowIndex: indexPath.row).backgroundColor
        return cell!
    }
}
