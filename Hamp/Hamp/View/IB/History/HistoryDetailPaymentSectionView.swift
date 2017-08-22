//
//  HistoryDetailPaymentSectionView.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 22/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class HistoryDetailPaymentSectionView: HistoryDetailSectionView {

    //MARK: Properties
    private var creditCardImageView: UIImageView!
    private var creditCardNumberLabel: UILabel!
    private var numberText: String = "xxxx xxxx xxxx 1234"
    
    //MARK: Life cycle
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupCreditCardImageView()
        setupCreditCardNumberLabel()
    
    }
}

private extension HistoryDetailPaymentSectionView {
    //MARK: Private
    func setupCreditCardImageView() {
        creditCardImageView = UIImageView.init(image: #imageLiteral(resourceName: "credit-card"))
        creditCardImageView.tintColor = .lightGray
        creditCardImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(creditCardImageView)
        
        NSLayoutConstraint.activate([
                creditCardImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: contentView.frame.height/3),
                creditCardImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
                creditCardImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -contentView.frame.height/3),
                creditCardImageView.widthAnchor.constraint(equalTo: creditCardImageView.heightAnchor, multiplier: creditCardImageView.frame.width/creditCardImageView.frame.height)
            ])
    }
    
    func setupCreditCardNumberLabel() {
        creditCardNumberLabel = UILabel.init()
        creditCardNumberLabel.text = numberText
        creditCardNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        creditCardNumberLabel.textColor = .lightGray
        creditCardNumberLabel.font = UIFont.systemFont(ofSize: 25, weight: .light)
        creditCardNumberLabel.adjustsFontSizeToFitWidth = true
        contentView.addSubview(creditCardNumberLabel)
        
        NSLayoutConstraint.activate([
            creditCardNumberLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            creditCardNumberLabel.leftAnchor.constraint(equalTo: creditCardImageView.rightAnchor, constant: 10),
            creditCardNumberLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            creditCardNumberLabel.heightAnchor.constraint(equalToConstant: 28)
            ])
    }
}
