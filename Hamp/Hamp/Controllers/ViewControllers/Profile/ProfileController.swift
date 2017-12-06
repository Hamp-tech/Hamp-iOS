//
//  ProfileController.swift
//  Hamp
//
//  Created by Aleix Baggerman on 26/9/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit
import HampKit
import SafariServices

class ProfileController: HampViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let numbersOfOthersCells = 7
    private(set) var provider: ProfileTableProvider
    private(set) var delegate: UITableViewDelegate
    
    init (contentProvider: ProfileTableProvider, dataSource: UITableViewDataSource, delegate: UITableViewDelegate) {
        self.provider = contentProvider
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.provider = ProfileInfoProvider (user: Hamp.Auth.user()!)
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
        print ("No se rick, parece falso")
    }
    
    fileprivate func setupTableView () {
        tableView.dataSource = self
        tableView.delegate = delegate
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
    }
    
    fileprivate func registerTableViewCells () {
        tableView.register(ProfileTextFieldCell.self, forCellReuseIdentifier: ProfileCellId.textFieldCell)
        tableView.register(ProfileDateCell.self, forCellReuseIdentifier: ProfileCellId.dateCell)
        tableView.register(ProfileGenderCell.self, forCellReuseIdentifier: ProfileCellId.genderCell)
        tableView.register(ProfilePickUpCell.self, forCellReuseIdentifier: ProfileCellId.pickUpCell)
        tableView.register(ProfileSwitchCell.self, forCellReuseIdentifier: ProfileCellId.switchCell)
        tableView.register(ProfileSignOutCell.self, forCellReuseIdentifier: ProfileCellId.simpleCell)
        tableView.register(ProfileUseInfoCell.self, forCellReuseIdentifier: ProfileCellId.infoCell)
    }
}

extension ProfileController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return provider.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return provider.numberOfItems(at: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellContent = provider.content(at: indexPath)!
        let cell = tableView.dequeueReusableCell(withIdentifier: cellContent.cellID, for: indexPath) as! ProfileCell
        cell.content = cellContent
//        cell.buttonDelegate = self
        return cell
    }
}

extension ProfileController: ProfileCellButtonDelegate {
    func signOut() {
        Hamp.Auth.signOut(onSucced: {
            let window = (UIApplication.shared.delegate as! AppDelegate).window
            let storyboard = UIStoryboard.init(name: "Login", bundle: Bundle.main)
            let viewController = storyboard.instantiateViewController(withIdentifier: loginViewControllerIdentifier)
            window?.rootViewController = viewController
            window?.makeKeyAndVisible()
        }) { (error) in
            
        }
    }
    
    func setupInfoController() {
        let url = URL (string: "https://www.google.es")
        let safariController = SFSafariViewController (url: url!)
        present (safariController, animated: true, completion: nil)
    }
}


