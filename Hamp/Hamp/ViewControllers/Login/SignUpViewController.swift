//
//  SignUpViewController.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 24/7/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class SignUpViewController: LogoTitleBaseViewController {

    //MARK: Properties
    @IBOutlet weak private var tableView: UITableView!
    
    let contentTypes = SignUpCellFactory.contentTypes
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.clear
        tableView.dataSource = self
        tableView.registerReusableCell(SignUpTextFieldTableViewCell.self)
        tableView.rowHeight = 58
        tableView.tableFooterView = UIView()
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
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func singUp(_ sender: UIButton) {
        
    }
}

extension SignUpViewController {
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
        let cell = tableView.dequeReusableCell(indexPath: indexPath) as SignUpTextFieldTableViewCell
        cell.content = SignUpCellFactory.content(by: contentTypes[indexPath.row])
        cell.inputDelegate = self
        cell.tag = indexPath.row
        return cell
    }
}

extension SignUpViewController: InputTextFieldDelegate {
    func textfieldPressReturn(_ textfield : InputTextField) {
        let tag = textfield.tag/10+1
        print(tag)
        if let nextCell = tableView.viewWithTag(tag) {
            nextCell.becomeFirstResponder()
            scrollToRow(to: tableView.indexPath(for: nextCell as! UITableViewCell)!)
        } else {
            _ = textfield.resignFirstResponder()
            scrollToRow(to: IndexPath.init(row: 0, section: 0))
        }
    }
    
    private func scrollToRow(to indexPath: IndexPath) {
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}
