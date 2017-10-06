//
//  StoresViewController.swift
//  Hamp
//
//  Created by Aleix Baggerman on 6/10/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class StoresViewController: HampViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var stores: [String] = ["Vendrell", "Vendrell"]
    
    override func viewDidLoad() {
        configureTableView ()
    }
    
    private func configureTableView () {
        tableView.dataSource = self
        tableView.backgroundColor = .white
    }
}

extension StoresViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath)
        return cell
    }
    
}
