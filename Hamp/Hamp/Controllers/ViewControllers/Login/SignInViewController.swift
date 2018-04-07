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

    //MARK: Private properties
    private var validationsManager = ValidationManager()
    
    //MARK: Public Properties
    @IBOutlet private weak var mailTextField: InputTextField!
    @IBOutlet private weak var passwordTextField: InputTextField!
    @IBOutlet private weak var optionsToolbar: SignInToolbar!
    @IBOutlet private weak var optionsToolbarBottomContraint: NSLayoutConstraint!
    @IBOutlet private weak var loginButton: HorizontalCircleGradientButton!
    
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
        
        let mailValidation = Validation.init(with: "mail", validationBlock: { () -> (Bool) in
            guard let text = self.mailTextField.text, text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count > 0 else { return false }
            return try! Regex.init(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").parse(input: text)
        }, validatedBlock: { (key, validated) in
            if(!validated) {
                self.mailTextField.textType = .error
            }
        })

        let password = Validation.init(with: "password", validationBlock: { () -> (Bool) in
            guard let text = self.passwordTextField.text, text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count > 0 else { return false }
            return true
        }, validatedBlock: { (key, validated) in
            if(!validated) {
                self.passwordTextField.textType = .error
            }
        })
            
        validationsManager.add(by: mailValidation)
        validationsManager.add(by: password)
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
        self.validationsManager.removeAll()
        self.dismiss(animated: true, completion: nil)
    }
    

    /// Present login sdk
    ///
    /// - Parameter sender: button pressed
    @IBAction func facebookLogin(_ sender: UIButton) {
//        FacebookAPIManager.logIn(
//            onViewController: self,
//            onSuccess: { (user, accessToken) in
//                Hamp.Auth.facebookLogIn(
//                    with: accessToken.authenticationToken,
//                    user: user,
//                    onSuccess: { (response) in
//                    self.loadingScreen.dismissViewController()
//                    self.showTabBarViewController()
//                },  onError: {(error) in
//                    self.showAlertError(with: "Facebook error", message: error.description)
//                    self.loadingScreen.dismissViewController()
//                })
//        },  onError: { (error) in
//                self.showAlertError(with: "Facebook error", message: error.localizedDescription)
//                self.loadingScreen.dismissViewController()
//        }, cancelled: {
//            self.loadingScreen.dismissViewController()
//        })
//        present(loadingScreen, animated: false, completion: nil)
    }
    
    /// Check if information is correct, if it is, log in, show error otherwise
    ///
    /// - Parameter sender: button pressed
    @IBAction func login(_ sender: UIButton) {
        guard let email = mailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        validationsManager.validate(onSuccess: {
            Hamp.Auth.signIn(email: email, password: password, onResponse: { [unowned self] (response) in
				DispatchQueue.main.async {
					self.hideLoading()
					if response.code == .ok {
						ProvidersManager.sharedInstance.downloadProvidersData()
						self.showTabBarViewController()
					} else {
						self.showAlertError(with: "Sign in error", message: response.message)
					}
				}
            })
			showLoading()
        }, onError: {
            print("Not correct fields")
        })
    }
    
}

private extension SignInViewController {
    //MARK: Private
    
    /// Enable login button if both textfields aren't empty
    func enableLoginButtonIfTextFieldsAreNotEmpty() {
        let textFieldsFilled = !mailTextField.isEmpty && !passwordTextField.isEmpty
        setLoginButtonEnabled(isEnabled: textFieldsFilled)
    }
    
    /// Set enabled to login button
    ///
    /// - Parameter isEnabled: isEnabled state
    func setLoginButtonEnabled(isEnabled: Bool) {
        loginButton.isEnabled = isEnabled
    }
    
    /// Show tab bar view controller
    func showTabBarViewController() {
        let identifier = tabBarNavigationViewControllerIdentifier
        let navigationController = UIStoryboard.init(name: "TabBar", bundle: Bundle.main)
            .instantiateViewController(withIdentifier: identifier)
        self.navigationController?.present(navigationController, animated: true, completion:nil)
    }
    
    /// Show alert error controller
    ///
    /// - Parameters:
    ///   - title: title to alert
    ///   - message: message to alert
    func showAlertError(with title: String,
                        message: String) {
        let alertController = UIAlertController.init(title: title,
                               message: message,
                               actions: .ok) { (foo) in
                                print(foo)
        }
        
        self.present(alertController, animated: true, completion: nil)
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
    
    func textFieldWasClear(_ textfield: InputTextField) {
         setLoginButtonEnabled(isEnabled: false)
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
        if let keyboardSize = (sender.userInfo![UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size {
            optionsToolbarBottomContraint.constant = toTop ? -keyboardSize.height : 0
            self.view.layoutIfNeeded()
        }
    }
}

