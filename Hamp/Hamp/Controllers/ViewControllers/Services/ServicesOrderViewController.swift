//
//  ServicesOrderViewController.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 17/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class ServicesOrderViewController: HampViewController {
    
    //MARK: IB Properties
    @IBOutlet weak var amountContainerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var amountPriceLabel: UILabel!
    @IBOutlet weak var payButton: HorizontalGradientButton!
    
    //MARK: Properties
    public var orderManager: OrderManager!
    public var services: [OrderableService]!
    private var padding: CGFloat = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        services = orderManager.servicesHired()
        collectionView?.registerReusableCell(ServicesOrderCollectionViewCell.self)
        collectionView?.contentInset = UIEdgeInsetsMake(0, 0, padding + amountContainerView.frame.height, 0)
        updateUI()
    }
    
    //MARK: Actions
    @IBAction func payWasPressed(_ sender: HorizontalGradientButton) {
        performSegue(withIdentifier: "showPaymentViewController", sender: nil)
        
    }
}

private extension ServicesOrderViewController {
    //MARK: Private
    func updateUI() {
        amountPriceLabel.text = "€ \(orderManager.amountServicesHired())"
        payButton.isEnabled = orderManager.amountServicesHired() > 0
    }
}

extension ServicesOrderViewController: UICollectionViewDataSource{
    
    //MARK: DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return services.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeReusableCell(indexPath: indexPath) as ServicesOrderCollectionViewCell
        cell.orderableService = services[indexPath.row]
        cell.delegate = self
        return cell
    }
}

extension ServicesOrderViewController: UICollectionViewDelegateFlowLayout {
    //MARK: Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 20
        let size: CGFloat = collectionView.frame.width - padding*2
        return CGSize.init(width: size, height: 74)
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
        updateUI()
    }
    
    func removeWasPressed(on cell: ServicesOrderCollectionViewCell, service: Service) {
        guard service.amount > 0 else { return }
        var o = service
        o.amount -= 1
        cell.needsUpdateUI()
        updateUI()
    }
    
}

