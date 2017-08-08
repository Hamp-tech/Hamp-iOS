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
//        setupTextField()
    }
}

private extension CreditCard {
    func setupFirstHorizontalSeparator() {
        firstHorizontalSeparatorLine = UIView.init()
        firstHorizontalSeparatorLine.backgroundColor = UIColor.lightGray
        firstHorizontalSeparatorLine.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(firstHorizontalSeparatorLine)
        var constraints = [NSLayoutConstraint]()
        let leftConstraint = NSLayoutConstraint.init(item: firstHorizontalSeparatorLine,
                                           attribute: .left,
                                           relatedBy: .equal,
                                           toItem: cardView,
                                           attribute: .left,
                                           multiplier: 1,
                                           constant: marginsSeparation)
        
        let rightConstraint = NSLayoutConstraint.init(item: firstHorizontalSeparatorLine,
                                           attribute: .right,
                                           relatedBy: .equal,
                                           toItem: cardView,
                                           attribute: .right,
                                           multiplier: 1,
                                           constant: -marginsSeparation)
        
        let topConstraint = NSLayoutConstraint.init(item: firstHorizontalSeparatorLine,
                                           attribute: .top,
                                           relatedBy: .equal,
                                           toItem: cardView,
                                           attribute: .top,
                                           multiplier: 1,
                                           constant: separatorYMargin)

        let heightConstraint = NSLayoutConstraint.init(item: firstHorizontalSeparatorLine,
                                           attribute: .height,
                                           relatedBy: .equal,
                                           toItem: nil,
                                           attribute: .notAnAttribute,
                                           multiplier: 1,
                                           constant: 1)
        firstHorizontalSeparatorLine.addConstraint(heightConstraint)
        
        constraints.append(leftConstraint)
        constraints.append(rightConstraint)
        constraints.append(topConstraint)
        
        cardView.addConstraints(constraints)
    }
    
    func setupSecondHorizontalSeparator() {
        secondHorizontalSeparatorLine = UIView.init()
        secondHorizontalSeparatorLine.backgroundColor = UIColor.lightGray
        secondHorizontalSeparatorLine.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(secondHorizontalSeparatorLine)
        var constraints = [NSLayoutConstraint]()
        let leftConstraint = NSLayoutConstraint.init(item: secondHorizontalSeparatorLine,
                                                     attribute: .left,
                                                     relatedBy: .equal,
                                                     toItem: cardView,
                                                     attribute: .left,
                                                     multiplier: 1,
                                                     constant: 17)
        
        let rightConstraint = NSLayoutConstraint.init(item: secondHorizontalSeparatorLine,
                                                      attribute: .right,
                                                      relatedBy: .equal,
                                                      toItem: cardView,
                                                      attribute: .right,
                                                      multiplier: 1,
                                                      constant: -17)
        
        let topConstraint = NSLayoutConstraint.init(item: secondHorizontalSeparatorLine,
                                                    attribute: .top,
                                                    relatedBy: .equal,
                                                    toItem: firstHorizontalSeparatorLine,
                                                    attribute: .top,
                                                    multiplier: 1,
                                                    constant: separatorYMargin)
        
        let heightConstraint = NSLayoutConstraint.init(item: secondHorizontalSeparatorLine,
                                                       attribute: .height,
                                                       relatedBy: .equal,
                                                       toItem: nil,
                                                       attribute: .notAnAttribute,
                                                       multiplier: 1,
                                                       constant: 1)
        secondHorizontalSeparatorLine.addConstraint(heightConstraint)
        
        constraints.append(leftConstraint)
        constraints.append(rightConstraint)
        constraints.append(topConstraint)
        
        cardView.addConstraints(constraints)
    }
    
//    func setupVerticalSeparatorLine
    
    func setupCardImageView() {
        cardImageView = UIImageView.init(image: #imageLiteral(resourceName: "CreditCard"))
        cardView.addSubview(cardImageView)
        cardImageView.translatesAutoresizingMaskIntoConstraints = false
        let imageHeight = separatorYMargin - 30
        let topMarginSeparation = separatorYMargin/2 - imageHeight/2 //Center to top section
        var constraints = [NSLayoutConstraint]()
        let leftConstraint = NSLayoutConstraint.init(item: cardImageView,
                                                    attribute: .left,
                                                    relatedBy: .equal,
                                                    toItem: cardView,
                                                    attribute: .left,
                                                    multiplier: 1,
                                                    constant: marginsSeparation)

        let topConstraint = NSLayoutConstraint.init(item: cardImageView,
                                                    attribute: .top,
                                                    relatedBy: .equal,
                                                    toItem: cardView,
                                                    attribute: .top,
                                                    multiplier: 1,
                                                    constant: topMarginSeparation)
        
        let aspectRationConstraint = NSLayoutConstraint.init(item: cardImageView,
                                                            attribute: .height,
                                                            relatedBy: .equal,
                                                            toItem: cardImageView,
                                                            attribute: .width,
                                                            multiplier: cardImageView.frame.size.height/cardImageView.frame.size.width,
                                                            constant: 0)
        
        let heightConstraint = NSLayoutConstraint.init(item: cardImageView,
                                                       attribute: .height,
                                                       relatedBy: .equal,
                                                       toItem: nil,
                                                       attribute: .notAnAttribute,
                                                       multiplier: 1,
                                                       constant: imageHeight)
        cardImageView.addConstraint(heightConstraint)
        
        constraints.append(leftConstraint)
        constraints.append(topConstraint)
        constraints.append(aspectRationConstraint)
        cardView.addConstraints(constraints)
    }
    
    func setupTextField() {
        creditNumberTextField = UITextField.init()
        creditNumberTextField.backgroundColor = UIColor.blue
        creditNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        creditNumberTextField.keyboardType = .numberPad
        creditNumberTextField.placeholder = "XXXX XXXX XXXX XXXX"
        cardView.addSubview(creditNumberTextField)
        
        var constraints = [NSLayoutConstraint]()
        let leftContraint = NSLayoutConstraint.init(item: creditNumberTextField,
                                                    attribute: .leftMargin,
                                                    relatedBy: .equal,
                                                    toItem: cardImageView,
                                                    attribute: .leftMargin,
                                                    multiplier: 3,
                                                    constant: 0)
        
        let rightConstraint = NSLayoutConstraint.init(item: creditNumberTextField,
                                                    attribute: .right,
                                                    relatedBy: .equal,
                                                    toItem: cardView,
                                                    attribute: .right,
                                                    multiplier: 1,
                                                    constant: -marginsSeparation)
        
        let topConstraint = NSLayoutConstraint.init(item: creditNumberTextField,
                                                    attribute: .top,
                                                    relatedBy: .equal,
                                                    toItem: cardImageView,
                                                    attribute: .top,
                                                    multiplier: 1,
                                                    constant: 0)
        
        let heightConstraint = NSLayoutConstraint.init(item: creditNumberTextField,
                                                       attribute: .height,
                                                       relatedBy: .equal,
                                                       toItem: cardImageView,
                                                       attribute: .height,
                                                       multiplier: 1.0,
                                                       constant: 0)
        
        
        
        
        constraints.append(leftContraint)
        constraints.append(rightConstraint)
        constraints.append(topConstraint)
        constraints.append(heightConstraint)
        
        cardView.addConstraints(constraints)
    }
    
    func setupVerticalSeparator() {
        verticalSeparatorLine = UIView.init()
        verticalSeparatorLine.backgroundColor = UIColor.lightGray
        verticalSeparatorLine.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(verticalSeparatorLine)
        
        var constraints = [NSLayoutConstraint]()
        let centerX = NSLayoutConstraint.init(item: verticalSeparatorLine,
                                                    attribute: .centerX,
                                                    relatedBy: .equal,
                                                    toItem: cardView,
                                                    attribute: .centerX,
                                                    multiplier: 1,
                                                    constant: 0)
        
        let centerY = NSLayoutConstraint.init(item: verticalSeparatorLine,
                                              attribute: .centerY,
                                              relatedBy: .equal,
                                              toItem: cardView,
                                              attribute: .centerY,
                                              multiplier: 1,
                                              constant: 0)
        let width = NSLayoutConstraint.init(item: verticalSeparatorLine,
                                            attribute: .width,
                                            relatedBy: .equal,
                                            toItem: nil,
                                            attribute: .notAnAttribute,
                                            multiplier: 1, 
                                            constant: 1)
        
        let height = NSLayoutConstraint.init(item: verticalSeparatorLine,
                                            attribute: .height,
                                            relatedBy: .equal,
                                            toItem: nil,
                                            attribute: .notAnAttribute,
                                            multiplier: 1,
                                            constant: separatorYMargin-15)
        constraints.append(centerX)
        constraints.append(centerY)
        constraints.append(width)
        constraints.append(height)
        cardView.addConstraints(constraints)
        
        
    }
}
