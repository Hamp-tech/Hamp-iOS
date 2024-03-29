//
//  CreditCard.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 7/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit
import InputMask
import HampKit

protocol CreditCardDelegate: class {
    func creditCardWasCompleted(_ creditCardUI: CreditCardUIController, creditCard: HampCreditCard)
    func creditCardWasIncompleted(_ creditCardUI: CreditCardUIController, creditCard: HampCreditCard)
}

class CreditCardUIController: UIView {
    
    weak var delegate: CreditCardDelegate?
    
    //MARK: Properties
    private var marginsSeparation: CGFloat = 17.0
    private var color = UIColor.gray
    private var cardView: UIView!
    private var firstHorizontalSeparatorLine: UIView!
    private var secondHorizontalSeparatorLine: UIView!
    private var verticalSeparatorLine: UIView!
    private var cardImageView: UIImageView!
    private var creditNumberTextField: UITextField!
    private var cvvTextField: UITextField!
    private var nameTextField: UITextField!
    private var dateTextField: UITextField!
    private var textFields = [UITextField]()
    private var hampCreditCard: HampCreditCard!
    private var inputMaskManager: CreditCardInputTextFieldMaskManager!
    lazy var separatorYMargin = {
        return self.bounds.height/3.0
    }()
    lazy var subviewsHeight = {
        return self.separatorYMargin-30
    }()

    //MARK: Constructors
    override init(frame: CGRect) {
        super.init(frame: frame)
        cardView = fromNib()
        backgroundColor = UIColor.white
        createInputTextManager()
        setupHampCreditCard()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        cardView = fromNib()
        backgroundColor = UIColor.white
        createInputTextManager()
        setupHampCreditCard()
        
    }
    
    convenience init() {
        self.init(frame: CGRect())
    }
    
    //MARK: Life cycle
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        createUI()
    }
    
}

private extension CreditCardUIController {
    //MARK: HampKit
    func setupHampCreditCard() {
        hampCreditCard = HampCreditCard.init()
    }
}

extension CreditCardUIController: CreditCardInputTextDelegate{
    
    //MARK: Backend
    func createInputTextManager() {
        inputMaskManager = CreditCardInputTextFieldMaskManager.init()
        inputMaskManager.delegate = self
    }
    
    func textfieldWasFilled(_ textField: UITextField, type: CreditCardTextFieldFactory.type, text: String) {
        let nextValue = type.rawValue + 1

        hampCreditCard.number = creditNumberTextField.text?.replacingOccurrences(of: " ", with: "")
        if let dtf = dateTextField.text, dtf.count > 0 {
            hampCreditCard.month = dtf.substring(with: 0..<2)
            hampCreditCard.year = dtf.substring(with: 3..<5)
        }
        hampCreditCard.cvv = cvvTextField.text
        hampCreditCard.name = nameTextField.text
        
        do {
            try hampCreditCard.validate()
            delegate?.creditCardWasCompleted(self, creditCard: hampCreditCard)
        } catch HampCreditCard.CreditCardError.invalidNumber {
            creditNumberTextField.shake()
        } catch HampCreditCard.CreditCardError.invalidMonth {
            dateTextField.shake()
        } catch HampCreditCard.CreditCardError.invalidYear {
            dateTextField.shake()
        } catch HampCreditCard.CreditCardError.invalidCVV {
            cvvTextField.shake()
        } catch HampCreditCard.CreditCardError.invalidName {
            nameTextField.shake()
        } catch {}
        
        guard nextValue < textFields.count else { return }
        textFields[nextValue].becomeFirstResponder()
    }
    
    func textFieldAreNotFilled(_ textField: UITextField, type: CreditCardTextFieldFactory.type) {
        self.delegate?.creditCardWasIncompleted(self, creditCard: hampCreditCard)
    }
    
    override func resignFirstResponder() -> Bool {
        textFields.forEach {
            $0.resignFirstResponder()
        }
        return super.resignFirstResponder()
    }
}

private extension CreditCardUIController {
    //MARK: UI
    func createUI() {
        setupFirstHorizontalSeparator()
        setupSecondHorizontalSeparator()
        setupVerticalSeparator()
        setupCardImageView()
        setupCreditNumberTextField()
        setupDateTextField()
        setupCVVTextfield()
        setupNameTextfield()
    }
    
    //MARK: UI Elements
    func setupFirstHorizontalSeparator() {
        firstHorizontalSeparatorLine = UIView.init()
        firstHorizontalSeparatorLine.backgroundColor = color
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
        secondHorizontalSeparatorLine.backgroundColor = color
        secondHorizontalSeparatorLine.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(secondHorizontalSeparatorLine)
        
        NSLayoutConstraint.activate([
            secondHorizontalSeparatorLine.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: marginsSeparation),
            secondHorizontalSeparatorLine.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -marginsSeparation),
            secondHorizontalSeparatorLine.topAnchor.constraint(equalTo: firstHorizontalSeparatorLine.topAnchor, constant: separatorYMargin),
            secondHorizontalSeparatorLine.heightAnchor.constraint(equalToConstant: 1)
            ])
    }
    
    func setupVerticalSeparator() {
        verticalSeparatorLine = UIView.init()
        verticalSeparatorLine.backgroundColor = color
        verticalSeparatorLine.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(verticalSeparatorLine)
        
        NSLayoutConstraint.activate([
            verticalSeparatorLine.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            verticalSeparatorLine.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            verticalSeparatorLine.widthAnchor.constraint(equalToConstant: 1),
            verticalSeparatorLine.heightAnchor.constraint(equalToConstant: separatorYMargin-15)
            ])
    }
        
    func setupCardImageView() {
        cardImageView = UIImageView.init(image: #imageLiteral(resourceName: "credit-card"))
        cardImageView.tintColor = UIColor.darkPink
        cardView.addSubview(cardImageView)
        cardImageView.translatesAutoresizingMaskIntoConstraints = false
        let imageHeight = subviewsHeight
        let topMarginSeparation = separatorYMargin/2 - imageHeight/2 //Center to top section
        
        NSLayoutConstraint.activate([
            cardImageView.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: marginsSeparation),
            cardImageView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: topMarginSeparation),
            cardImageView.heightAnchor.constraint(equalTo: cardImageView.widthAnchor, multiplier: cardImageView.frame.height/cardImageView.frame.width, constant: 0),
            cardImageView.heightAnchor.constraint(equalToConstant: imageHeight)
            ])
    }
    
    func setupCreditNumberTextField() {
        creditNumberTextField = CreditCardTextFieldFactory.textField(by: .number)
        inputMaskManager.subscribe(textfield: creditNumberTextField,
                                   type: .number,
                                   inputMaskType: .format("[0000] [0000] [0000] [0000]"))
        
        cardView.addSubview(creditNumberTextField)
        textFields.append(creditNumberTextField)
        
        NSLayoutConstraint.activate([
            creditNumberTextField.leftAnchor.constraint(equalTo: cardImageView.rightAnchor, constant: marginsSeparation),
            creditNumberTextField.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -marginsSeparation),
            creditNumberTextField.topAnchor.constraint(equalTo: cardImageView.topAnchor),
            creditNumberTextField.heightAnchor.constraint(equalTo: cardImageView.heightAnchor)
            ])
    }
    
    func setupDateTextField() {
        dateTextField = CreditCardTextFieldFactory.textField(by: .date)
        inputMaskManager.subscribe(textfield: dateTextField,
                                   type: .date,
                                   inputMaskType: .format("[00]/[00]"))
        cardView.addSubview(dateTextField)
        textFields.append(dateTextField)
    
        NSLayoutConstraint.activate([
            dateTextField.centerYAnchor.constraint(equalTo: verticalSeparatorLine.centerYAnchor),
            dateTextField.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: marginsSeparation),
            dateTextField.rightAnchor.constraint(equalTo: verticalSeparatorLine.centerXAnchor, constant: 0),
            dateTextField.heightAnchor.constraint(equalToConstant: subviewsHeight)
            ])
    }
    
    func setupCVVTextfield() {
        cvvTextField = CreditCardTextFieldFactory.textField(by: .cvv)
        inputMaskManager.subscribe(textfield: cvvTextField,
                                   type: .cvv,
                                   inputMaskType: .format("[000]"))
        cardView.addSubview(cvvTextField)
        textFields.append(cvvTextField)
        

        NSLayoutConstraint.activate([
            cvvTextField.leftAnchor.constraint(equalTo: verticalSeparatorLine.centerXAnchor, constant: 0),
            cvvTextField.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -marginsSeparation),
            cvvTextField.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            cvvTextField.heightAnchor.constraint(equalTo: creditNumberTextField.heightAnchor)
            ])
    }
    
    func setupNameTextfield() {
        nameTextField = CreditCardTextFieldFactory.textField(by: .name)
        inputMaskManager.subscribe(textfield: nameTextField,
                                   type: .name,
                                   inputMaskType: .none)
        cardView.addSubview(nameTextField)
        textFields.append(nameTextField)
        
        let height = subviewsHeight
        let topMarginSeparation = separatorYMargin/2 - height/2
        
        NSLayoutConstraint.activate([
            nameTextField.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: marginsSeparation),
            nameTextField.topAnchor.constraint(equalTo: secondHorizontalSeparatorLine.centerYAnchor, constant: topMarginSeparation),
            nameTextField.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -marginsSeparation),
            nameTextField.heightAnchor.constraint(equalToConstant: height)
            ])
        
    }
}
