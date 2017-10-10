//
//  ServicesCollectionViewController.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 16/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class ServicesCollectionViewController: HampCollectionViewController {
    
    //MARK: Properties
    private var orderServices = LaundryServicesProvider.orderServices
    private var orderManager: OrderManager!
    private var basketButton: BasketButton!
    private var videoTutorialButton: UIButton!
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        orderManager = OrderManager.init()
        orderManager.delegate = self
        
        collectionView?.registerReusableCell(ServicesCollectionViewCell.self)
        basketButton = BarRightButtonsFactory.basketButton()
        basketButton.isEnabled = false
        basketButton.addTarget(self, action: #selector(hireServices(_:)), for: .touchUpInside)
        addRightBarButtonWhenLargeTitles(rightButton: TrailingBarButtonItem.init(with: basketButton))
        
        videoTutorialButton = BarRightButtonsFactory.videoTutorialButton()
        videoTutorialButton.addTarget(self, action: #selector(showMap(_:)), for: .touchUpInside)
        addRightBarButtonWhenLargeTitles(rightButton: TrailingBarButtonItem.init(with: videoTutorialButton))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.reloadData()
        basketButton.updateAmount(with: amount())
        orderManager.removeEmptyServices()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showNavigationBarRightButtons()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        hideNavigationBarRightButtons()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let id = segue.identifier else { return }
        
        switch id {
        case "showOrderServicesDetail":
            let vc = (segue.destination as! ServiceDetailViewController)
            vc.orderService = (sender as! OrderableService)
            vc.orderManager = orderManager
        case "showOrderViewController":
            let vc = (segue.destination as! ServicesOrderViewController)
            vc.orderManager = orderManager
        default:
            break
        }
    }
}

extension ServicesCollectionViewController: OrderManagerDelegate {
    
    //MARK: Order manager delegate
    func orderWasUpdated(on manager: OrderManager) {
        basketButton.isEnabled = true
        basketButton.updateAmount(with: amount())
    }
    
    func orderWasEmptied(on manager: OrderManager) {
        basketButton.isEnabled = false
    }
}

extension ServicesCollectionViewController {
    //MARK: Actions
    @objc func hireServices(_ sender: UIButton) {
        performSegue(withIdentifier: "showOrderViewController", sender: nil)
    }
    
    @objc func showMap(_ sender: UIButton) {
        
        let mapVC = self.storyboard!.instantiateViewController(withIdentifier: "HistoryDetailMapViewController") as! MapController
        
        let invoiceVC = self.storyboard!.instantiateViewController(withIdentifier: "HistoryDetailInvoiceViewController") as! OrderController
        
        let vc = StoresViewController(contentViewController: mapVC, draggableViewController: invoiceVC)
        let nav = UINavigationController(rootViewController: vc)
        
        present(nav, animated: true, completion: nil)
    }
}

internal extension ServicesCollectionViewController {
    //MARK: DataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return orderServices.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeReusableCell(indexPath: indexPath) as ServicesCollectionViewCell
        cell.orderableService = orderServices[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    //MARK: Delegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {        
        performSegue(withIdentifier: "showOrderServicesDetail", sender: orderServices[indexPath.row])
    }
}

extension ServicesCollectionViewController: ServicesCollectionViewCellDelegate {
    func addWasPressed(on cell: ServicesCollectionViewCell, orderableService: OrderableService) {
        guard orderableService.service.amount >= 0 else { return }
        var o = orderableService
        o.service.amount += 1
        orderManager.addIfNotExists(service: o)
        cell.needsUpdateUI()
    }
    
    func removeWasPressed(on cell: ServicesCollectionViewCell, orderableService: OrderableService) {
        guard orderableService.service.amount > 0 else { return }
        var o = orderableService
        o.service.amount -= 1
        orderManager.deleteServiceIfAmountZero(service: o)
        cell.needsUpdateUI()
    }
    
    private func amount() -> Int {
        return orderManager.amountServicesHired()
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

