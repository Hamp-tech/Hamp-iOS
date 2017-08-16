//
//  ServicesCollectionViewController.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 16/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class ServicesCollectionViewController: UICollectionViewController {
    
    //MARK: Properties
    private var orderServices = OrderServicesProvider.orderServices
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.registerReusableCell(ServicesCollectionViewCell.self)
        
    }
}

extension ServicesCollectionViewController {
    //MARK: DataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return orderServices.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeReusableCell(indexPath: indexPath) as ServicesCollectionViewCell
        cell.order = orderServices[indexPath.row]
        return cell
    }
}

extension ServicesCollectionViewController: UICollectionViewDelegateFlowLayout {
    //MARK: Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 10
        let size: CGFloat = collectionView.frame.width/2 - padding*2
        return CGSize.init(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 10, left: 12.5, bottom: 10, right: 12.5)
    }
}
