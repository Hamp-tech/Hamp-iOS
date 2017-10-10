//
//  StoresListViewController.swift
//  Hamp
//
//  Created by Aleix Baggerman on 6/10/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class StoresListViewController: PulleyChildViewController {
    
    //Replace for IBOutled
    var tableView: UITableView!
    
    var stores: [String] = ["Vendrell", "Vendrell", "Calafell", "Barcelona"]
    
    override func viewDidLoad() {
        configureTableView ()
        view.backgroundColor = .red
    }
    
    private func configureTableView () {
        tableView = UITableView ()
        view.addSubview(tableView)
        tableView.frame.size = self.view.frame.size
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .yellow
        
        let nib = UINib.init(nibName: "StoreTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "StoreTableViewCell")
    }
}

extension StoresListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreTableViewCell") as! StoreTableViewCell
        return cell
    }
    
}

extension StoresListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
