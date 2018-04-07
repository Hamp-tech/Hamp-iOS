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
    let cellID = "HistoryCellID"
    
    var dataProvider: DataProvider!
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells ()
        tableView.separatorStyle = .none
    }
    
    private func registerCells () {
        let nib = UINib(nibName: "NewHistoryTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellID)
    }
}

//MARK: TableView data source
extension HistoryTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        return cell
    }
}

//MARK: TableView delegate
extension HistoryTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}







