//
//  SignUpCellFactory.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 7/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

public struct SignUpCellFactory {
    static func cell(by content: SignUpCellContent,
                     tableView: UITableView,
                     indexPath: IndexPath,
                     delegate: SignUpContentable) -> SignUpBaseTableViewCell {
        var cell: SignUpBaseTableViewCell!
        switch content.inputType {
        case .name, .surname, .username, .mail, .password, .repeatPassword, .phone, .birthday:
            cell = tableView.dequeReusableCell(indexPath: indexPath) as SignUpTextFieldTableViewCell
            (cell as! SignUpTextFieldTableViewCell).inputDelegate = (delegate as! InputTextFieldDelegate)
        case .gender:
            cell = tableView.dequeReusableCell(indexPath: indexPath) as SignUpGenderTableViewCell
        default:
            break
        }
        
        cell.content = content
        
        return cell
    }
}
//case name
//case surname
//case username
//case mail
//case password
//case repeatPassword
//case phone
//case birthday
//case gender
//case unknown

