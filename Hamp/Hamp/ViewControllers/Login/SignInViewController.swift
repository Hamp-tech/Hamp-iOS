//
//  SignInViewController.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 23/7/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class SignInViewController: LogoTitleBaseViewController {

    //MARK: Properties
    @IBOutlet weak private var mailTextField: InputTextField!
    @IBOutlet weak private var passwordTextField: InputTextField!
    @IBOutlet weak private var optionsToolbar: SignInToolbar!
    @IBOutlet weak var optionsToolbarBottomContraint: NSLayoutConstraint!
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mailTextField.type = .username
        passwordTextField.type = .password
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupKeyboardNotifications()
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}

private extension SignInViewController {
    func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(sender: Notification) {
        moveToolBar(sender: sender, toTop: true)
    }
    
    @objc func keyboardWillHide(sender: Notification) {
        moveToolBar(sender: sender, toTop: false)
    }
    
    func moveToolBar(sender: Notification, toTop: Bool) {
        if let keyboardSize = sender.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? CGRect {
            let duration = sender.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double ?? 0.5
            optionsToolbarBottomContraint.constant = toTop ? -keyboardSize.height : 0
            UIView.animate(withDuration: duration, animations: {
                self.view.layoutIfNeeded()
            })
            
        }
    }
}

