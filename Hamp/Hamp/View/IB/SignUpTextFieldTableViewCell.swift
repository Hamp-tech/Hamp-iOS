//
//  SignUpTextFieldTableViewCell.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 31/7/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class SignUpTextFieldTableViewCell: UITableViewCell, SignUpContentableCell, Reusable {
    
    //MARK: IB properties
    @IBOutlet weak var inputTextField: InputTextField!
    
    //MARK: Properties
    weak var inputDelegate: InputTextFieldDelegate?
    
    var content: SignUpCellContent!
    
    //MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.contentView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.clear
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        configure()
    }
    
    /// Public
    func configure() {
        inputTextField.placeholder = content.placeholder
        inputTextField.delegate = inputDelegate
        inputTextField.tag = tag*10
        inputTextField.type = content.inputType
        inputTextField.text = content.text
        inputTextField.keyboardType = content.keyboardType
        inputTextField.autocapitazationType = content.autocapitalizationType
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        content = nil
    }
}

extension SignUpTextFieldTableViewCell {
    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        return inputTextField.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        return inputTextField.resignFirstResponder()
    }
}