//
//  OrderInfoCell.swift
//  Hamp
//
//  Created by Aleix Baggerman on 27/9/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class OrderInfoCell: OrderCollectionViewCell {
    
    override var content: OrderHistoryContent? {
        didSet {
            captionLabel.text = content?.title
            
            guard let lockerImage = content?.images?[0] else {return}
            guard let padLockImage = content?.images?[1] else {return}
            guard let clockImage = content?.images?[2] else {return}
            

        }
    }
    
    private let captionLabel: UILabel = {
        let label = UILabel ()
        label.font = UIFont.helveticaBold(withSize: 20)
        return label
    } ()
    
    private let separationView: UIView = {
        let view = UIView ()
        view.backgroundColor = UIColor.init(red: 151/255, green: 151/255, blue: 151/255, alpha: 1)
        return view
    } ()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView.init()
        tv.dataSource = self
        return tv
    } ()
    
    override func draw(_ rect: CGRect) {
        contentView.addSubview (captionLabel)
        contentView.addSubview (separationView)
        contentView.addSubview(tableView)

        captionLabel.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 53, width: 0, height: 24)
        separationView.anchor(top: captionLabel.bottomAnchor, left: captionLabel.leftAnchor, bottom: nil, right: captionLabel.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1.5)
        tableView.anchor(top: separationView.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        tableView.separatorStyle = .none
        
        registerCells()
    }
    
    private func registerCells () {
        let nib = UINib.init(nibName: "LockTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "LockTableViewCell")
    }
}

//MARK: TableViewDataSource
extension OrderInfoCell: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content?.lockers?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LockTableViewCell", for: indexPath) as! LockTableViewCell
        cell.images = content?.images
        cell.locker = content?.lockers?[indexPath.row]
        return cell
    }
}

//MARK: TableViewDelegate
extension OrderInfoCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}


















