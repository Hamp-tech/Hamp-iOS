//
//  ServicesOrderViewController.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 17/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class ServicesOrderViewController: HampCollectionViewController {

    //MARK: Properties
    public var orderManager: OrderManager!
    public var services: [Service]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.registerReusableCell(ServicesOrderCollectionViewCell.self)
        services = orderManager.servicesHired()
    }
}

extension ServicesOrderViewController {
    
    //MARK: DataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return services.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeReusableCell(indexPath: indexPath) as ServicesOrderCollectionViewCell
        cell.service = services[indexPath.row]
        cell.delegate = self
        return cell
    }
}

extension ServicesOrderViewController: UICollectionViewDelegateFlowLayout {
    //MARK: Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 20
        let size: CGFloat = collectionView.frame.width - padding*2
        return CGSize.init(width: size, height: 62)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 10, left: 20, bottom: 10, right: 20)
    }
}

extension ServicesOrderViewController: ServicesOrderCellDelegate {
    //MARK: Cell Delegate
    func addWasPressed(on cell: ServicesOrderCollectionViewCell, service: Service) {
        guard service.amount >= 0 else { return }
        var o = service
        o.amount += 1
        cell.needsUpdateUI()
    }
    
    func removeWasPressed(on cell: ServicesOrderCollectionViewCell, service: Service) {
        guard service.amount > 0 else { return }
        var o = service
        o.amount -= 1
        cell.needsUpdateUI()
    }

}
