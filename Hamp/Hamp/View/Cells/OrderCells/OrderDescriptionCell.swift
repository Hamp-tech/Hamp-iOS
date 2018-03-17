//
//  OrderDescriptionCell.swift
//  Hamp
//
//  Created by Aleix Baggerman on 27/9/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class OrderDescriptionCell: OrderCollectionViewCell {
    
    override var content: OrderHistoryContent? {
        didSet {
            captionLabel.text = content?.title
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
    
    var collectionView: UICollectionView!
    
    var productImages: [UIImage]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCollectionView ()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        contentView.addSubview(captionLabel)
        contentView.addSubview(separationView)
        contentView.addSubview(collectionView)
        
        captionLabel.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 53, width: 0, height: 24)
        separationView.anchor(top: captionLabel.bottomAnchor, left: captionLabel.leftAnchor, bottom: nil, right: captionLabel.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1.5)
        collectionView.anchor(top: separationView.bottomAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, paddingTop: 15, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 75)
    }
    
    fileprivate func configureCollectionView () {
        let layout = UICollectionViewFlowLayout ()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView (frame: CGRect.zero, collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(DescriptionImageCell.self, forCellWithReuseIdentifier: "ProductCellID")
    }
}

extension OrderDescriptionCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return content?.services?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCellID", for: indexPath) as! DescriptionImageCell
        cell.backgroundColor = UIColor.white
        cell.image = ServiceImageFactory.getImageWith(serviceName: content!.services![indexPath.item].name)
        cell.numberOfItems = content?.services?[indexPath.item].amount
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension OrderDescriptionCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize (width: collectionView.frame.width/3.5, height: self.collectionView.frame.height)
    }
}
