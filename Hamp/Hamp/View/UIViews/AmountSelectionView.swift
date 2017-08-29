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
    public weak var delegate: AmountSelectionViewDelegate?
    private lazy var minusButton: UIButton = {
        let minusButton = UIButton.init(type: .system)
        minusButton.setTitle("-", for: .normal)
        minusButton.titleLabel?.font = UIFont.helveticaBold(withSize: 36)
        minusButton.setTitleColor(UIColor.ligthPink, for: .normal)
        minusButton.addTarget(self, action: #selector(removeWasPressed(sender:)), for: .touchUpInside)
        
        return minusButton
    }()
    private lazy var addButton: UIButton = {
        let addButton = UIButton.init(type: .system)
        addButton.setTitle("+", for: .normal)
        addButton.titleLabel?.font = UIFont.helveticaBold(withSize: 36)
        addButton.setTitleColor(UIColor.ligthPink, for: .normal)
        addButton.addTarget(self, action: #selector(addWasPressed(sender:)), for: .touchUpInside)
        
        return addButton
    }()
    private lazy var amountLabel: UILabel = {
        let amountLabel = UILabel.init()
        amountLabel.font = UIFont.fredoka(withSize: 26)
        amountLabel.text = String.init(delegate?.initialAmount() ?? 0)
        amountLabel.textColor = UIColor.gray
        amountLabel.textAlignment = .center
        
        return amountLabel
    }()

    private lazy var stack : UIStackView = {
        let s = UIStackView(frame: self.bounds)
        s.axis = .horizontal
        s.distribution = .fillEqually
        s.alignment = .fill
        s.spacing = 0
        s.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        s.addArrangedSubview(self.minusButton)
        s.addArrangedSubview(self.amountLabel)
        s.addArrangedSubview(self.addButton)
        
        return s
    }()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        addSubview(minusButton)
        addSubview(addButton)
        addSubview(amountLabel)
        addSubview(stack)
    }
}

extension AmountSelectionView {
    func updateAmount(with amount: Int) {
        amountLabel.text = String.init(amount)
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

