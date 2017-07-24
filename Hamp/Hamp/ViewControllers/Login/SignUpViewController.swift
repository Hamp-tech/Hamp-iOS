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
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.clear

    }
    
    //MARK: Actions
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func singUp(_ sender: UIButton) {
        
    }
}
