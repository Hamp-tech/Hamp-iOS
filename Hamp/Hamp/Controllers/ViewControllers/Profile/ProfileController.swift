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
    
    let textFieldCellsInfo = [
        ProfileTextFieldInfo (captionTitle: "Nombre", textFieldText: "Judith"),
        ProfileTextFieldInfo (captionTitle: "Apellido", textFieldText: "Moreno Navarro"),
        ProfileTextFieldInfo (captionTitle: "E-mail", textFieldText: "judithmoreno@gmail.com"),
        ProfileTextFieldInfo (captionTitle: "Teléfono", textFieldText: "690690690")
    ]
    
    let numbersOfOthersCells = 7
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView ()
        registerTableViewCells ()
    }
    
    fileprivate func setupTableView () {
        tableView.dataSource = self
        tableView.delegate = self
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

//MARK: TableViewDataSource

extension ProfileController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numbersOfOthersCells + textFieldCellsInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row < textFieldCellsInfo.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCellId.textFieldCell, for: indexPath) as! ProfileTextFieldCell
            cell.backgroundColor = .white
            cell.info = textFieldCellsInfo [indexPath.row]
            return cell
        } else {
            
            switch indexPath.row {
            case 4:
                    let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCellId.dateCell, for: indexPath) as! ProfileDateCell
                    cell.dateTextField.text = "22/33/4444"
                    return cell
            case 5:
                let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCellId.genderCell, for: indexPath)
                return cell
            case 6:
                let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCellId.pickUpCell, for: indexPath)
                return cell
            case 7:
                let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCellId.switchCell, for: indexPath) as! ProfileSwitchCell
                cell.captionLabel.text = "Valorar Hamp"
                return cell
            case 8:
                let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCellId.switchCell, for: indexPath) as! ProfileSwitchCell
                cell.captionLabel.text = "Notificaciones activadas"
                return cell
            case 9:
                let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCellId.simpleCell, for: indexPath) as! ProfileSimpleCell
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCellId.infoCell, for: indexPath)
                return cell
            }
        }
    }
}

//MARK: TableViewDelegate
extension ProfileController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < textFieldCellsInfo.count {
            return 100
        } else if indexPath.row < textFieldCellsInfo.count + 3 {
            return 80
        } else {
            return 50
        }
    }
}
