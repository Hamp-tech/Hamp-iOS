//
//  OrderPaymentCell.swift
//  Hamp
//
//  Created by Aleix Baggerman on 27/9/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class OrderPaymentCell: UICollectionViewCell {
    
    var creditCardNumber: String? {
        didSet {
            guard let creditCardNumber = creditCardNumber, creditCardNumber.count == 19 else {
                creditCardNumberLabel.text = "???? ???? ???? ????"
                return
            }
            creditCardNumberLabel.text = codifyCreditCardNumber (creditNumber: creditCardNumber)
        }
    }
    
    private let captionLabel: UILabel = {
        let label = UILabel ()
        label.font = UIFont.helveticaBold(withSize: 20)
        label.text = "Método de pago"
        return label
    } ()
    
    private let separationView: UIView = {
        let view = UIView ()
        view.backgroundColor = UIColor.init(red: 151/255, green: 151/255, blue: 151/255, alpha: 1)
        return view
    } ()
    
    let paymentImageView: UIImageView = {
        let imageView = UIImageView ()
        imageView.image = #imageLiteral(resourceName: "credit-card").withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.init(red: 155/255, green: 155/255, blue: 155/255, alpha: 1)
        return imageView
    } ()
    
    private let creditCardNumberLabel: UILabel = {
        let label = UILabel ()
        label.text = "xxxx xxxx xxxx 1234"
        label.font = UIFont.helvetica(withSize: 18)
        label.textColor = UIColor.init(red: 155/255, green: 155/255, blue: 155/255, alpha: 1)
        return label
    } ()
    
    override func draw(_ rect: CGRect) {
        contentView.addSubview(captionLabel)
        contentView.addSubview(separationView)
        contentView.addSubview(paymentImageView)
        contentView.addSubview(creditCardNumberLabel)
        
        captionLabel.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 53, width: 0, height: 24)
        separationView.anchor(top: captionLabel.bottomAnchor, left: captionLabel.leftAnchor, bottom: nil, right: captionLabel.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1.5)
        paymentImageView.anchor(top: separationView.bottomAnchor, left: captionLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 40, height: 28)
        creditCardNumberLabel.anchor(top: paymentImageView.topAnchor, left: paymentImageView.rightAnchor, bottom: paymentImageView.bottomAnchor, right: captionLabel.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    fileprivate func codifyCreditCardNumber (creditNumber: String) -> String {
        let lastNumbers = creditNumber.substring(from: creditNumber.index(creditNumber.endIndex, offsetBy: -4))
        let secretNumbers = "xxxx xxxx xxxx "
        let finalNumber = secretNumbers + lastNumbers
        return finalNumber
    }
    
}
