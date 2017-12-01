//
//  SignUpViewController.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 24/7/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit
import HampKit

class SignUpViewController: LogoTitleBaseViewController {
    
    //MARK: Properties
    @IBOutlet weak private var tableView: UITableView!
    
    let contentTypes = SignUpCellContentFactory.contentTypes
    var contents: [SignUpCellContent]!
    var validationsManager = ValidationManager()
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createContens()
        createValidations()
        setupTableView()
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
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.validationsManager.removeAll()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func singUp(_ sender: UIButton) {
        for i in 0..<tableView.numberOfRows(inSection: 0) {
            let cell = tableView.cellForRow(at: IndexPath.init(row: i, section: 0))
            cell?.resignFirstResponder()
        }
        
        validationsManager.validate(
            onSuccess: {
                let name = contents.filter{ $0.inputType == .name }.first?.text
                let surname = contents.filter{ $0.inputType == .surname }.first?.text
                let mail = contents.filter{ $0.inputType == .mail }.first?.text
                let phone = contents.filter{ $0.inputType == .phone }.first?.text
                let password = contents.filter{ $0.inputType == .password }.first?.text
                let birthday = contents.filter{ $0.inputType == .birthday }.first?.text
                let gender = contents.filter{ $0.inputType == .gender }.first?.text
                
                let user = try! HampUser.init(identifier: nil, name: name!, surname: surname!, mail: mail!, phone: phone!, birthday: birthday!, gender: gender, tokenFCM: nil, language: nil, OS: "iOS", signupDate: nil)
                HampUserCache.setUser(user: user)
                Hamp.Auth.signUp(with: user, password: password!, onSuccess: { (response) in
                    self.showTabBarViewController()
                }, onError: { (error) in
                    self.showAlertError(with: "Sign up error", message: error.description)
                })
        },  onError: { () in
                print("Incorrect")
        })

    }
}

private extension SignUpViewController {
    //MARK: Private
    /// Create contents to cells
    func createContens() {
        contents = contentTypes.map { SignUpCellContentFactory.content(by: $0) }
    }
    
    /// Create validations to cell
    func createValidations() {
        var idx = 0
        contents.map({ value in
            Validation.init(
                validationBlock: validationBlock(by: value),
                validatedBlock: { (key, validated) in
                    if let cell = self.tableView.cellForRow(at: IndexPath.init(row: Int(key)!, section: 0)) as? SignUpTextFieldTableViewCell {
                        cell.inputTextField.textType = validated ? .auto : .error
                    }
            })
        }).forEach {
            $0.key = String(idx)
            idx += 1
            self.validationsManager.add(by: $0)
        }
    }
    
    /// Setup UI of Tableview
    func setupTableView() {
        tableView.backgroundColor = UIColor.clear
        tableView.dataSource = self
        tableView.registerReusableCell(SignUpTextFieldTableViewCell.self)
        tableView.registerReusableCell(SignUpGenderTableViewCell.self)
        tableView.rowHeight = 58
        tableView.tag = -1
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
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

private extension SignUpViewController {
    /// Create a new validation deppends
    ///
    /// - Parameter content: cell content
    /// - Returns: validation to cell
    func validationBlock(by content: SignUpCellContent) -> Validation.ValidationBlock {
        switch content.inputType {
        case .name:
            return {
                self.ensureCellTextIfCorrect(text: content.text, block: { (text) -> (Bool) in
                    return true
                })
            }
        case .surname:
            return {
                self.ensureCellTextIfCorrect(text: content.text, block: { (text) -> (Bool) in
                    return true
                })
            }
            
        case .mail:
            return {
                self.ensureCellTextIfCorrect(text: content.text, block: { (text) -> (Bool) in
                    return try! HampRegex.init(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").parse(input: text)
                })
            }
        case .phone:
            return {
                self.ensureCellTextIfCorrect(text: content.text, block: { (text) -> (Bool) in
                    return try! HampRegex.init(pattern: "^[9|6|7][0-9]{8}$").parse(input: text)
                })
            }
        case .birthday:
            return {
                self.ensureCellTextIfCorrect(text: content.text, block: { (text) -> (Bool) in
                    return true
                })
            }
        case .password:
            return {
                self.ensureCellTextIfCorrect(text: content.text, block: { (text) -> (Bool) in
                    let c = self.contents.filter { $0.inputType == .repeatPassword }.first
                    return text == c?.text
                })
            }
        case .repeatPassword:
            return {
                self.ensureCellTextIfCorrect(text: content.text, block: { (text) -> (Bool) in
                    let c = self.contents.filter { $0.inputType == .password }.first
                    return text == c?.text
                })
            }
        default:
            return { return true }
        }
    }
    
    /// Ensure if parameter text is not nil and 
    ///
    /// - Parameters:
    ///   - text: text to ensure
    ///   - block: called when pass the first requirements
    /// - Returns:if text is correct and if text is valid on validation block
    func ensureCellTextIfCorrect(text: String?, block: (String) -> (Bool)) -> Bool {
        guard let t = text, t.count > 0 else { return false }
        guard t.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count > 0 else { return false }
        return block(t)
    }
}

extension SignUpViewController {
    //MARK: Keyboard
    func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(sender: Notification) {
        if let keyboardFrame: NSValue = sender.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            self.tableView.contentInset.bottom = keyboardRectangle.height + 20
        }
    }
    
    @objc func keyboardWillHide(sender: Notification) {
        self.tableView.contentInset.bottom = 0
    }
}

extension SignUpViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SignUpCellFactory.cell(by: contents[indexPath.row],
                                          tableView: tableView,
                                          indexPath: indexPath,
                                          delegate: self)
        cell.tag = indexPath.row+1
        return cell
    }
}

extension SignUpViewController: GenderCellDelegate {
    
    func manCheckboxWasPressed(_ cell: SignUpGenderTableViewCell) {
        cell.content.text = cell.genderSelected.rawValue
    }
    
    func womanCheckboxWasPressed(_ cell: SignUpGenderTableViewCell) {
        cell.content.text = cell.genderSelected.rawValue
    }
}

extension SignUpViewController: InputTextFieldDelegate {
    func textfieldPressReturn(_ textfield : InputTextField) {
        let tag = textfield.tag/10+1
        
        if let nextCell = tableView.viewWithTag(tag) {
                nextCell.becomeFirstResponder()
                scrollToRow(to: tableView.indexPath(for: nextCell as! UITableViewCell)!)
        } else {
            _ = textfield.resignFirstResponder()
            scrollToRow(to: IndexPath.init(row: 0, section: 0))
        }
    }
    
    func textfieldEndEditing(_ textfield: InputTextField) {
        let tag = textfield.tag/10
        if let cell = tableView.viewWithTag(tag) {
            (cell as! SignUpTextFieldTableViewCell).content.text = textfield.text
        }
    }
    
    private func scrollToRow(to indexPath: IndexPath) {
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}

