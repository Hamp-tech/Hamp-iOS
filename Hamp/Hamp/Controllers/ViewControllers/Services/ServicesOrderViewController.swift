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
    private var padding: CGFloat = 20
    private var floatButtonSize: CGFloat = 40
    private var payButton: VerticalGradientButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        services = orderManager.servicesHired()
        
        collectionView?.registerReusableCell(ServicesOrderCollectionViewCell.self)
        collectionView?.contentInset = UIEdgeInsetsMake(0, 0, padding + floatButtonSize, 0)
        
        setupFloatButton()
    }
}

private extension ServicesOrderViewController {
    //MARK: Private
    func setupFloatButton() {
        payButton = VerticalGradientButton.init(type: .system)
        payButton.backgroundColor = UIColor.darkPink
        payButton.roundCorners(with: floatButtonSize/2)
        payButton.translatesAutoresizingMaskIntoConstraints = false
        payButton.setImage(UIImage.init(named: "credit-card")?.scaled(withScale: 0.6), for: .normal)
        payButton.tintColor = .white
        view.addSubview(payButton)
        
        NSLayoutConstraint.activate([
            payButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            payButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding),
            payButton.widthAnchor.constraint(equalToConstant: floatButtonSize),
            payButton.heightAnchor.constraint(equalToConstant: floatButtonSize)
        ])
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

