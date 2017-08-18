//
//  ServicesPaymentFooterView.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 18/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

protocol ServicesPaymentFooterDelegate: class {
    func footerWasPressed(on footerView: ServicesPaymentFooterView)
}

class ServicesPaymentFooterView: UICollectionReusableView, Reusable {
    
    //MARK: Properties
    @IBOutlet weak var visibleContainerView: UIView!
    weak var delegate: ServicesPaymentFooterDelegate?
    
    //MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(addCreditCardWasPressed(sender:)))
        visibleContainerView.addGestureRecognizer(tapGesture)
    }
    
    //MARK: Actions
    @objc private func addCreditCardWasPressed(sender: UITapGestureRecognizer) {
        delegate?.footerWasPressed(on: self)
    }
}
