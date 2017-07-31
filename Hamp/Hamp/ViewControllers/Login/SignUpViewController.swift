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
    
    //MARK: Actions
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func singUp(_ sender: UIButton) {
        
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
        if let nextTextfield = tableView.viewWithTag(tag) {
            nextTextfield.becomeFirstResponder()
        } else {
            _ = textfield.resignFirstResponder()
        }
    }
}
