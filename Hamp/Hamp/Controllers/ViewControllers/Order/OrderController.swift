//
//  OrderController.swift
//  Hamp
//
//  Created by Aleix Baggerman on 27/9/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class OrderController: PulleyChildViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var contentProvider: OrderHistoryTableProvider!
    
    var transaction: DBTransaction?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureController ()
        registerCollectionViewCells()
        collectionView.isScrollEnabled = false;
        contentProvider = OrderHistoryContentProvider.init(transaction: transaction!)
        dateLabel.text = transaction?.deliveryDate
        priceLabel.text = "\(transaction!.booking!.price)€"
    }
    
    func configureController () {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
    }
    
    func registerCollectionViewCells () {
        collectionView.register(OrderDescriptionCell.self, forCellWithReuseIdentifier: OrderCellsID.description)
        collectionView.register(OrderInfoCell.self, forCellWithReuseIdentifier: OrderCellsID.info)
        collectionView.register(OrderPaymentCell.self, forCellWithReuseIdentifier: OrderCellsID.payment)
    }
    
    override func childDidChangePosition(position: PulleyPosition) {
        collectionView.isScrollEnabled = position == .open
        collectionView.isUserInteractionEnabled = position == .open
    }
}

//MARK: CollectionViewDataSource
extension OrderController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentProvider.numberOfItems(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let content = contentProvider.getContentWith(indexPath: indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: content.identifier, for: indexPath) as! OrderCollectionViewCell
        cell.content = content
        cell.backgroundColor = .white
        return cell
    }
}

//MARK: CollectionViewDelegate
extension OrderController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case 0:
            return CGSize (width: collectionView.frame.width, height: 100)
        case 1:
            return CGSize (width: collectionView.frame.width, height: 150)
        default:
            return CGSize (width: collectionView.frame.width, height: 190)
        }
    }
}






