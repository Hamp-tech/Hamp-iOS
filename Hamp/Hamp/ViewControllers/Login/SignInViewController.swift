//
//  SignInViewController.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 23/7/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit
import HampKit


class SignInViewController: LogoTitleBaseViewController {

    //MARK: Properties
    @IBOutlet weak private var mailTextField: InputTextField!
    @IBOutlet weak private var passwordTextField: InputTextField!
    @IBOutlet weak private var optionsToolbar: SignInToolbar!
    @IBOutlet weak var optionsToolbarBottomContraint: NSLayoutConstraint!
    @IBOutlet weak var loginButton: GradientButton!
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mailTextField.type = .mail
        mailTextField.placeholder = InputType.mail.description
        mailTextField.delegate = self
        mailTextField.autocapitazationType = .none
        mailTextField.keyboardType = .emailAddress
        
        passwordTextField.type = .password
        passwordTextField.placeholder = InputType.password.description
        passwordTextField.delegate = self
        
        enableLoginButtonIfTextFieldsAreNotEmpty()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardNotifications()
    }
    
    //MARK: Actions
    
    /// Dismiss view controller
    ///
    /// - Parameter sender: button pressed
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /// Present forgot password view controller
    ///
    /// - Parameter sender: button pressed
    @IBAction func forgotPassword(_ sender: UIButton) {
        print("Forgot password")
    }
    
    /// Present login sdk
    ///
    /// - Parameter sender: button pressed
    @IBAction func facebookLogin(_ sender: UIButton) {
        FacebookAPIManager.logIn(
            onViewController: self,
            onSuccess: { (user, accessToken) in
                Hamp.Auth.facebookLogIn(
                    with: accessToken.authenticationToken,
                    user: user,
                    onSuccess: { (response) in

                },  onError: {(error) in

                })
            
        },  onError: { (error) in
                print(error)
        })
    }
    
    /// Check if information is correct, if it is, log in, show error otherwise
    ///
    /// - Parameter sender: button pressed
    @IBAction func login(_ sender: UIButton) {
        Hamp.Auth.signIn(
            mail: mailTextField.text!,
            password: passwordTextField.text!,
            onSuccess: { (response) in

        },  onError: { (error) in
            
        })
    }
    
}

private extension SignInViewController {
    //MARK: Private
    
    /// Enable login button if both textfields aren't empty
    func enableLoginButtonIfTextFieldsAreNotEmpty() {
        let textFieldsFilled = !mailTextField.isEmpty && !passwordTextField.isEmpty
        loginButton.isEnabled = textFieldsFilled
    }
    
    
}

extension SignInViewController: InputTextFieldDelegate {
    func textfieldPressReturn(_ textfield: InputTextField) {
        switch textfield {
        case mailTextField:
            let _ = passwordTextField.becomeFirstResponder()
        case passwordTextField:
            let _ = passwordTextField.resignFirstResponder()
        default:
            break
        }
    }
    
    func textField(_ textField: InputTextField, replacementString string: String) {
        enableLoginButtonIfTextFieldsAreNotEmpty()
    }

}

private extension SignInViewController {
    func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
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

