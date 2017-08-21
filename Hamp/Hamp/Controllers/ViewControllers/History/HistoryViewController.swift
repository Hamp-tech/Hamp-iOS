//
//  HistoryViewController.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 21/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class HistoryViewController: HampTableViewController {

    let history = 1
    let rowHeight: CGFloat = 87
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
}

private extension HistoryViewController {
    //MARK: UI
    func setupTableView() {
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView.init()
        tableView.registerReusableCell(HistoryTableViewCell.self)
        tableView.rowHeight = rowHeight
        tableView.showsVerticalScrollIndicator = false
        tableView.alwaysBounceVertical = false //Has a ui problem when rows count = 5
        
        let bottomInfiniteLine = UIView.init()
        bottomInfiniteLine.backgroundColor = UIColor.darkPink
        bottomInfiniteLine.translatesAutoresizingMaskIntoConstraints = false
        tableView.addSubview(bottomInfiniteLine)
        
        NSLayoutConstraint.activate([
            bottomInfiniteLine.topAnchor.constraint(equalTo: tableView.topAnchor, constant: rowHeight*CGFloat.init(history)),
            bottomInfiniteLine.widthAnchor.constraint(equalToConstant: 2),
            bottomInfiniteLine.heightAnchor.constraint(equalToConstant:  500),
            bottomInfiniteLine.leftAnchor.constraint(equalTo: tableView.leftAnchor, constant: 20)
            ])
    }
}

extension HistoryViewController {
   
    //MARK: TableView datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeReusableCell(indexPath: indexPath) as HistoryTableViewCell
        return cell
    }
}

extension HistoryViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showHistoryDetail", sender: nil)
    }
}
