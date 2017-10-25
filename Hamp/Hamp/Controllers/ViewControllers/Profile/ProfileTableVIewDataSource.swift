//
//  ProfileTableVIewDataSource.swift
//  Hamp
//
//  Created by Aleix Baggerman on 22/10/2017.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class ProfileTableViewDataSource: NSObject, UITableViewDataSource {
    
    private(set) var provider: ProfileTableProvider
    
    init(contentProvider: ProfileTableProvider) {
        self.provider = contentProvider
        super.init()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return provider.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return provider.numberOfItems(at: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellContent = provider.content(at: indexPath)!
        let cell = tableView.dequeueReusableCell(withIdentifier: cellContent.cellID, for: indexPath) as! ProfileCell
        cell.content = cellContent
        return cell
    }
    
}
