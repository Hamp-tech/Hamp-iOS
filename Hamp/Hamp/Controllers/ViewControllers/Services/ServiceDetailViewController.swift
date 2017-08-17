//
//  ServiceDetailViewController.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 17/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class ServiceDetailViewController: HampViewController {
    
    //MARK: IB Properties
    @IBOutlet weak private var serviceImageView: UIImageView!
    @IBOutlet weak private var descriptionTextView: UITextView!
    @IBOutlet weak private var amountSelectionView: AmountSelectionView!
    @IBOutlet weak private var textViewHeightConstraint: NSLayoutConstraint!
    
    //MARK: Properties
    public var orderService: OrderableService!
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        adjustTextView()
        serviceImageView.image = UIImage.init(named: orderService.imageName)
        title = orderService.service.name
        amountSelectionView.delegate = self
    }
}

private extension ServiceDetailViewController {
    //MARK: Private
    func adjustTextView() {
        let size = descriptionTextView.sizeThatFits(CGSize.init(width: descriptionTextView.frame.width, height: CGFloat.init(Float.greatestFiniteMagnitude)))
        textViewHeightConstraint.constant = size.height
    }
}

extension ServiceDetailViewController: AmountSelectionViewDelegate {
    
    func removeWasPressed(on view: AmountSelectionView) {
        guard orderService.service.amount > 0 else { return }
        orderService.service.amount -= 1
        view.updateAmount(with: orderService.service.amount)
    }
    
    func addWasPressed(on view: AmountSelectionView) {
        guard orderService.service.amount >= 0 else { return }
        orderService.service.amount += 1
        view.updateAmount(with: orderService.service.amount)
    }
    
    func initialAmount() -> Int {
        return orderService.service.amount
    }
}

