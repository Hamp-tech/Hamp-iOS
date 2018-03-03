//
//  RestorePasswordViewController.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 24/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit
import HampKit

class RestorePasswordViewController: LogoTitleBaseViewController {

    //MARK: IB properties
    @IBOutlet weak var mailTextfield: InputTextField!
    private var validationManager = ValidationManager.init()
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mailTextfield.type = .mail
        mailTextfield.placeholder = InputType.mail.description
        mailTextfield.delegate = self
        mailTextfield.autocapitazationType = .none
        mailTextfield.keyboardType = .emailAddress
        
        let validation = Validation.init(validationBlock: { () -> (Bool) in
            guard let text = self.mailTextfield.text, text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count > 0 else { return false }
            return try! Regex.init(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").parse(input: text)
        }, validatedBlock: {(_, _) in })
        validationManager.add(by: validation)
    }
    
    //MARK: Actions
    @IBAction func cancelWasPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func restoreWasPressed(_ sender: HorizontalCircleGradientButton) {
        validationManager.validate(onSuccess: {
            print("OK")
            self.dismiss(animated: true, completion: nil)
        }, onError: { () in
            self.mailTextfield.shake()
        })
    }
}

extension RestorePasswordViewController: InputTextFieldDelegate {
    func textfieldPressReturn(_ textfield: InputTextField) {
        _ = textfield.resignFirstResponder()
    }
}
