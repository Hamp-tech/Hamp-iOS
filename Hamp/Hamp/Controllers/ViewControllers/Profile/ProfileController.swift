//
//  ProfileController.swift
//  Hamp
//
//  Created by Aleix Baggerman on 26/9/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class ProfileController: HampViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let numbersOfOthersCells = 7
    private(set) var provider: ProfileTableProvider
    private(set) var dataSource: UITableViewDataSource
    private(set) var delegate: UITableViewDelegate
    
    init (contentProvider: ProfileTableProvider, dataSource: UITableViewDataSource, delegate: UITableViewDelegate) {
        self.provider = contentProvider
        self.dataSource = dataSource
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.provider = ProfileInfoProvider ()
        self.dataSource = ProfileTableViewDataSource.init(contentProvider: provider)
        self.delegate = ProfileTableViewDelegate.init(provider: provider)
        super.init (coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView ()
        registerTableViewCells ()
        addSaveButton()
    }
    
    private func addSaveButton () {
        let saveButton = UIButton (type: .system)
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = .yellow
        saveButton.frame = CGRect (x: 0, y: 0, width: 59, height: 24)
        saveButton.addTarget(self, action: #selector (editProfile), for: .touchUpInside)
        
        let trailingButton = TrailingBarButtonItem (with: saveButton)
        addRightBarButtonWhenLargeTitles(rightButton: trailingButton)
    }
    
    @objc func editProfile () {
        print ("HEI")
    }
    
    fileprivate func setupTableView () {
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        tableView.backgroundColor = .white
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
    }
    
    fileprivate func registerTableViewCells () {
        tableView.register(ProfileTextFieldCell.self, forCellReuseIdentifier: ProfileCellId.textFieldCell)
        tableView.register(ProfileDateCell.self, forCellReuseIdentifier: ProfileCellId.dateCell)
        tableView.register(ProfileGenderCell.self, forCellReuseIdentifier: ProfileCellId.genderCell)
        tableView.register(ProfilePickUpCell.self, forCellReuseIdentifier: ProfileCellId.pickUpCell)
        tableView.register(ProfileSwitchCell.self, forCellReuseIdentifier: ProfileCellId.switchCell)
        tableView.register(ProfileSimpleCell.self, forCellReuseIdentifier: ProfileCellId.simpleCell)
        tableView.register(ProfileUseInfoCell.self, forCellReuseIdentifier: ProfileCellId.infoCell)
    }
}

