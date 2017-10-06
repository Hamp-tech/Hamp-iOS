//
//  OrderController.swift
//  Hamp
//
//  Created by Aleix Baggerman on 27/9/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class OrderController: PulleyChildViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureController ()
        registerCollectionViewCells()
        collectionView.isScrollEnabled = false;
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
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OrderCellsID.payment, for: indexPath)
            cell.backgroundColor = .white
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OrderCellsID.description, for: indexPath) as! OrderDescriptionCell
            cell.backgroundColor = .white
            cell.productImages = [#imageLiteral(resourceName: "blanket"),#imageLiteral(resourceName: "cushion"),#imageLiteral(resourceName: "curtain"),#imageLiteral(resourceName: "big-bag")]
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OrderCellsID.info, for: indexPath) as! OrderInfoCell
            cell.backgroundColor = .white
            cell.title = "Entrega"
            cell.infoText = ["13", "1 2 3 4", "Tarde"]
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OrderCellsID.info, for: indexPath) as! OrderInfoCell
            cell.backgroundColor = .white
            cell.title = "Recogida"
            return cell
        }
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






