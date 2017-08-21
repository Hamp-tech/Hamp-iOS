//
//  HistoryDetailSectionView.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 21/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class HistoryDetailSectionView: UIView {

    //MARK: IB properties
    @IBInspectable var title: String = ""
    
    //MARK: Properties
    private var headerView: HistoryDetailSectionHeaderView!
    public private(set) var contentView: UIView!
    
    
    //MARK: Life cycle
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        setupHeaderView()
        setupContentView()
    }
}

private extension HistoryDetailSectionView {
    //MARK: Private
    func setupHeaderView() {
        headerView = HistoryDetailSectionHeaderView.init()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.title = title
        addSubview(headerView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leftAnchor.constraint(equalTo: leftAnchor),
            headerView.rightAnchor.constraint(equalTo: rightAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 38)
            ])
    }
    
    func setupContentView() {
        contentView = UIView.init()
        contentView.translatesAutoresizingMaskIntoConstraints = false
//        contentView.backgroundColor = UIColor.red
        addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
}
