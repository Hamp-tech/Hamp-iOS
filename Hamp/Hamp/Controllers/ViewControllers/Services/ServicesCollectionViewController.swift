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
    private var basketButton: BasketButton!
    private var videoTutorialButton: UIButton!
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.registerReusableCell(ServicesCollectionViewCell.self)
        basketButton = BarRightButtonsFactory.basketButton()
        basketButton.isEnabled = false
//        basketButton.addTarget(self, action: #selector(), for: .touchUpInside)
        addRightBarButtonWhenLargeTitles(rightButton: basketButton)
        
        videoTutorialButton = UIButton.init(type: .system)
        videoTutorialButton.setImage(#imageLiteral(resourceName: "video-tutorial"), for: .normal)

        addRightBarButtonWhenLargeTitles(rightButton: videoTutorialButton)
        
    }
    
}

internal extension ServicesCollectionViewController {
    //MARK: DataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return orderServices.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeReusableCell(indexPath: indexPath) as ServicesCollectionViewCell
        cell.service = orderServices[indexPath.row]
        cell.delegate = self
        return cell
    }
}

extension ServicesCollectionViewController: ServicesCollectionViewCellDelegate {
    func addWasPressed(on cell: ServicesCollectionViewCell, order: OrderableService) {
        guard order.amount >= 0 else { return }
        var o = order
        o.amount += 1
        cell.updateAmountLabel()
        basketButton.updateAmount(with: amount())
    }
    
    func removeWasPressed(on cell: ServicesCollectionViewCell, order: OrderableService) {
        guard order.amount > 0 else { return }
        var o = order
        o.amount -= 1
        cell.updateAmountLabel()
        basketButton.updateAmount(with: amount())
    }
    
    private func amount() -> Int {
        return orderServices.filter{$0.amount > 0}.reduce(0) { (initial, service) in
            initial + service.amount
        }
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

