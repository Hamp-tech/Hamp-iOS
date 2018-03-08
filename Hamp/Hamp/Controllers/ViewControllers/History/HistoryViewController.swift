//
//  HistoryViewController.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 21/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class HistoryViewController: HampTableViewController {

    // MARK : - Properties
    var dataProvider: DataProvider!
    private var cellSizeCalculator: HistoryCellSizeCalculator!
    
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        precondition(dataProvider != nil, "Provide a data provider")
        cellSizeCalculator = HistoryCellSizeCalculator.init(topMargin: 8, bottomMargin: 8)
        setupTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
}

private extension HistoryViewController {
    //MARK: UI
    func setupTableView() {
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView.init()
        tableView.registerReusableCell(HistoryTableViewCell.self)
        tableView.showsVerticalScrollIndicator = false
        tableView.alwaysBounceVertical = false //Has a ui problem when rows count = 5
        
        let bottomInfiniteLine = UIView.init()
        bottomInfiniteLine.backgroundColor = UIColor.darkPink
        bottomInfiniteLine.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(bottomInfiniteLine, at: 0)
        
        let topAnchorMargin = dataProvider.getData().reduce(0) { (initial, next) in
            return initial + cellSizeCalculator.height(by: (next as! DBTransaction).booking!)
        }
        
        NSLayoutConstraint.activate([
            bottomInfiniteLine.topAnchor.constraint(equalTo: tableView.topAnchor, constant: topAnchorMargin),
            bottomInfiniteLine.widthAnchor.constraint(equalToConstant: 2),
            bottomInfiniteLine.heightAnchor.constraint(equalToConstant:  1000),
            bottomInfiniteLine.leftAnchor.constraint(equalTo: tableView.leftAnchor, constant: 20)
            ])
    }
}

extension HistoryViewController {
   
    //MARK: TableView datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProvider.getData().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeReusableCell(indexPath: indexPath) as HistoryTableViewCell
        cell.transaction = dataProvider.getDataWith(index: indexPath.item) as! DBTransaction
        return cell
    }
}

extension HistoryViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! HistoryTableViewCell
        
        let mapVC = self.storyboard!.instantiateViewController(withIdentifier: "HistoryDetailMapViewController") as! MapController
        mapVC.point = cell.transaction.booking!.point
        
        let invoiceVC = self.storyboard!.instantiateViewController(withIdentifier: 
            "HistoryDetailInvoiceViewController") as! OrderController
        
        invoiceVC.transaction = cell.transaction
        
        let historyDetailViewController = HistoryBookingDetailViewController.init(contentViewController: mapVC, draggableViewController: invoiceVC)
        historyDetailViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(historyDetailViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellSizeCalculator.height(by: (dataProvider.getDataWith(index: indexPath.item) as! DBTransaction).booking!)
    }
}
