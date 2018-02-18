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

    let numbersOfOthersCells = 7
    
    @IBOutlet weak var tableView: UITableView!
    private(set) var provider: ProfileTableProvider!
    private(set) var delegate: UITableViewDelegate!

    
    init (contentProvider: ProfileTableProvider, dataSource: UITableViewDataSource, delegate: UITableViewDelegate) {
        self.provider = contentProvider
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init (coder: aDecoder)
        self.provider = ProfileInfoProvider (user: Hamp.Auth.user(), parent: self)
        self.delegate = ProfileTableViewDelegate.init(provider: provider)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView ()
        registerTableViewCells ()
        addSaveButton()
    }

    private func addSaveButton () {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Edit", style: .plain, target: self, action: #selector (editProfile))
    }
    
    @objc func editProfile () {
        provider.setCellsEnabled(enabled: !provider.areCellsEnabled())
        let title = provider.areCellsEnabled() ? "Save" : "Edit"
        self.navigationItem.rightBarButtonItem?.title = title
        self.tableView.reloadData()
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
        cell.isEnabled = provider.areCellsEnabled()
        return cell
    }
}

extension ProfileController: GMDatePickerDelegate {
    func gmDatePicker(_ gmDatePicker: GMDatePicker, didSelect date: Date) {
        let indexPath = IndexPath(row: 4, section: 0)
        var content = provider.content(at: indexPath)
        content?.textFieldText = DateConverter.convertDateToString(date: date)
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        tableView.reloadData()
    }
    
    func gmDatePickerWillAppear(_ gmDatePicker: GMDatePicker) {
        let userBirthday = DateConverter.getDateFromString(iso8601Date: Hamp.Auth.user()?.birthday ?? "1994-11-07T13:15:30Z") 
        gmDatePicker.config.startDate = userBirthday
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    func gmDatePickerDidCancelSelection(_ gmDatePicker: GMDatePicker) {
        self.navigationItem.rightBarButtonItem?.isEnabled = true
    }
    
    func gmDatePickerSetMaxDate(_ gmDatePicker: GMDatePicker) -> Date {
        let maxYear = DateConverter.getActualYear() - 15
        return DateConverter.getMaxDateFromYear(year: maxYear)
    }
}

