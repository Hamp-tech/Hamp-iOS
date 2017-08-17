//
//  AmountSelectionView.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 17/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

protocol AmountSelectionViewDelegate: class {
    func removeWasPressed(on view: AmountSelectionView)
    func addWasPressed(on view: AmountSelectionView)
    func initialAmount() -> Int
}

class AmountSelectionView: UIView {

    //MARK: Properties
    private var minusButton: UIButton!
    private var addButton: UIButton!
    private var amountLabel: UILabel!
    public weak var delegate: AmountSelectionViewDelegate?
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupMinusButton()
        setupAddButton()
        setupAmountLabel()
    }
}

extension AmountSelectionView {
    func updateAmount(with amount: Int) {
        amountLabel.text = String.init(amount)
    }
}

private extension AmountSelectionView {
    //MARK: Private
    func setupMinusButton() {
        minusButton = UIButton.init(type: .system)
        minusButton.setTitle("-", for: .normal)
        minusButton.titleLabel?.font = UIFont.helveticaBold(withSize: 36)
        minusButton.setTitleColor(UIColor.ligthPink, for: .normal)
        minusButton.addTarget(self, action: #selector(removeWasPressed(sender:)), for: .touchUpInside)
        addSubview(minusButton)
        
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            minusButton.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            minusButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            minusButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            minusButton.widthAnchor.constraint(equalToConstant: 25)
            ])
    }
    
    func setupAddButton() {
        addButton = UIButton.init(type: .system)
        addButton.setTitle("+", for: .normal)
        addButton.titleLabel?.font = UIFont.helveticaBold(withSize: 36)
        addButton.setTitleColor(UIColor.ligthPink, for: .normal)
        addButton.addTarget(self, action: #selector(addWasPressed(sender:)), for: .touchUpInside)
        addSubview(addButton)
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            addButton.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            addButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            addButton.widthAnchor.constraint(equalToConstant: 25)
            ])
    }
    
    func setupAmountLabel() {
        amountLabel = UILabel.init()
        amountLabel.font = UIFont.fredoka(withSize: 26)
        amountLabel.text = String.init(delegate?.initialAmount() ?? 0)
        amountLabel.textColor = UIColor.gray
        amountLabel.textAlignment = .center
        addSubview(amountLabel)
        
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            amountLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            amountLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            amountLabel.leftAnchor.constraint(equalTo: minusButton.rightAnchor, constant: 0),
            amountLabel.rightAnchor.constraint(equalTo: addButton.leftAnchor, constant: 0)
            ])
    }
}

private extension AmountSelectionView {
    @objc func removeWasPressed(sender: UIButton) {
        delegate?.removeWasPressed(on: self)
    }
    
    @objc func addWasPressed(sender: UIButton) {
        delegate?.addWasPressed(on: self)
    }
}

