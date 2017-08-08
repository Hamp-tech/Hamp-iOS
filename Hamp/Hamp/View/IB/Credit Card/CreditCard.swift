//
//  CreditCard.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 7/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class CreditCard: UIView {
    
    //MARK: Properties
    private var marginsSeparation: CGFloat = 17.0
    private var cardView: UIView!
    private var firstHorizontalSeparatorLine: UIView!
    private var secondHorizontalSeparatorLine: UIView!
    private var verticalSeparatorLine: UIView!
    private var cardImageView: UIImageView!
    private var creditNumberTextField: UITextField!
    lazy var separatorYMargin = {
        return self.bounds.height/3.0
    }()

    //MARK: Constructors
    override init(frame: CGRect) {
        super.init(frame: frame)
        cardView = fromNib()
        backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        cardView = fromNib()
        backgroundColor = UIColor.white
        
    }
    
    convenience init() {
        self.init(frame: CGRect())
    }
    
    //MARK: Life cycle
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupFirstHorizontalSeparator()
        setupSecondHorizontalSeparator()
        setupCardImageView()
        setupVerticalSeparator()
        setupTextField()
    }
    
}

private extension CreditCard {
    func setupFirstHorizontalSeparator() {
        firstHorizontalSeparatorLine = UIView.init()
        firstHorizontalSeparatorLine.backgroundColor = UIColor.lightGray
        firstHorizontalSeparatorLine.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(firstHorizontalSeparatorLine)
        
        NSLayoutConstraint.activate([
            firstHorizontalSeparatorLine.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: marginsSeparation),
            firstHorizontalSeparatorLine.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -marginsSeparation),
            firstHorizontalSeparatorLine.topAnchor.constraint(equalTo: cardView.topAnchor, constant: separatorYMargin),
            firstHorizontalSeparatorLine.heightAnchor.constraint(equalToConstant: 1)
            ])
    }
    
    func setupSecondHorizontalSeparator() {
        secondHorizontalSeparatorLine = UIView.init()
        secondHorizontalSeparatorLine.backgroundColor = UIColor.lightGray
        secondHorizontalSeparatorLine.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(secondHorizontalSeparatorLine)
        
        NSLayoutConstraint.activate([
            secondHorizontalSeparatorLine.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: marginsSeparation),
            secondHorizontalSeparatorLine.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -marginsSeparation),
            secondHorizontalSeparatorLine.topAnchor.constraint(equalTo: firstHorizontalSeparatorLine.topAnchor, constant: separatorYMargin),
            secondHorizontalSeparatorLine.heightAnchor.constraint(equalToConstant: 1)
            ])
    }
        
    func setupCardImageView() {
        cardImageView = UIImageView.init(image: #imageLiteral(resourceName: "CreditCard"))
        cardView.addSubview(cardImageView)
        cardImageView.translatesAutoresizingMaskIntoConstraints = false
        let imageHeight = separatorYMargin - 30
        let topMarginSeparation = separatorYMargin/2 - imageHeight/2 //Center to top section
        
        NSLayoutConstraint.activate([
            cardImageView.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: marginsSeparation),
            cardImageView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: topMarginSeparation),
            cardImageView.heightAnchor.constraint(equalTo: cardImageView.widthAnchor, multiplier: cardImageView.frame.height/cardImageView.frame.width, constant: 0),
            cardImageView.heightAnchor.constraint(equalToConstant: imageHeight)
            ])
    }
    
    func setupTextField() {
        creditNumberTextField = UITextField.init()
        creditNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        creditNumberTextField.textColor = UIColor.gray
        creditNumberTextField.keyboardType = .numberPad
        creditNumberTextField.placeholder = "XXXX XXXX XXXX XXXX"
        cardView.addSubview(creditNumberTextField)
        
        NSLayoutConstraint.activate([
            creditNumberTextField.leftAnchor.constraint(equalTo: cardImageView.rightAnchor, constant: marginsSeparation),
            creditNumberTextField.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -marginsSeparation),
            creditNumberTextField.topAnchor.constraint(equalTo: cardImageView.topAnchor),
            creditNumberTextField.heightAnchor.constraint(equalTo: cardImageView.heightAnchor)
            ])
    }
    
    func setupVerticalSeparator() {
        verticalSeparatorLine = UIView.init()
        verticalSeparatorLine.backgroundColor = UIColor.lightGray
        verticalSeparatorLine.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(verticalSeparatorLine)
        
        NSLayoutConstraint.activate([
            verticalSeparatorLine.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            verticalSeparatorLine.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            verticalSeparatorLine.widthAnchor.constraint(equalToConstant: 1),
            verticalSeparatorLine.heightAnchor.constraint(equalToConstant: separatorYMargin-15)
            ])
        
        
    }
}
