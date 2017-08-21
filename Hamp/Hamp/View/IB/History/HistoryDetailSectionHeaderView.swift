//
//  HistoryDetailSectionHeaderView.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 21/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class HistoryDetailSectionHeaderView: UIView {
    
    //MARK: IB properties
    var title: String = ""
    
    //MARK: Properties
    private var titleLabel: UILabel!
    private var line: UIView!
    private var lineHeight: CGFloat = 2
    private var titleLabelHeight: CGFloat = 24

    //MARK: Life cycle
    override func updateConstraints() {
        super.updateConstraints()
        setupTitleLabel()
        setupLine()
        backgroundColor = UIColor.white
    }
    
}

private extension HistoryDetailSectionHeaderView {
    //MARK: Private
    func setupTitleLabel() {
        titleLabel = UILabel.init()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: titleLabelHeight)
            ])
    }
    
    func setupLine() {
        line = UIView.init()
        line.backgroundColor = UIColor.lightGray
        line.translatesAutoresizingMaskIntoConstraints = false
        addSubview(line)
        
        NSLayoutConstraint.activate([
            line.heightAnchor.constraint(equalToConstant: lineHeight),
            line.leftAnchor.constraint(equalTo: leftAnchor),
            line.rightAnchor.constraint(equalTo: rightAnchor),
            line.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
}
