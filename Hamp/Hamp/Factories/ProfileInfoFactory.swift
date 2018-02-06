//
//  ProfileInfoFactory.swift
//  Hamp
//
//  Created by Aleix Baggerman on 30/11/2017.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation
import HampKit
import SafariServices

struct ProfileInfoFactory {
    static func createProfileInfo<T: UIViewController>(user: HampUser?, parent: T) -> [[UserContent]] where T: GMDatePickerDelegate {
        
        let dummyUser = try! HampUser.init(identifier: nil, name: "Aleix", surname: "Diaz", mail: "aleix.diaz@gmail.com", password: "123123", phone: "666666666", birthday: nil, gender: "M", signupDate: nil, tokenFCM: nil, os: nil, language: nil, lastActivity: nil, unsubscribed: nil, stripeID: nil)
    
        let user = user ?? dummyUser
        
        let gender = user.gender ?? "X"
        let birthday = user.birthday ?? "DD/MM/YYYY"
        
        return [
            [
                ProfileContent.init(cellID: ProfileCellId.textFieldCell, labelText: "Nombre", textFieldText: user.name),
                ProfileContent.init(cellID: ProfileCellId.textFieldCell, labelText: "Apellido", textFieldText: user.surname),
                ProfileContent.init(cellID: ProfileCellId.textFieldCell, labelText: "E-mail", textFieldText: user.mail),
                ProfileContent.init(cellID: ProfileCellId.textFieldCell, labelText: "Teléfono", textFieldText: user.phone),
                ProfileContent.init(cellID: ProfileCellId.dateCell, labelText: "Fecha de nacimiento", textFieldText: birthday, actionBlock: {
                    let datePicker: GMDatePicker = {
                        let picker = GMDatePicker()
                        picker.delegate = parent
                        picker.config.startDate = Date()
                        picker.config.animationDuration = 0.5
                        picker.config.cancelButtonTitle = "Cancel"
                        picker.config.confirmButtonTitle = "Confirm"
                        picker.config.contentBackgroundColor = UIColor(red: 253/255.0, green: 253/255.0, blue: 253/255.0, alpha: 1)
                        picker.config.headerBackgroundColor = UIColor(red: 244/255.0, green: 244/255.0, blue: 244/255.0, alpha: 1)
                        picker.config.confirmButtonColor = UIColor.black
                        picker.config.cancelButtonColor = UIColor.black
                        return picker
                    }()
                    
                    datePicker.show(inVC: parent)
                }),
                ProfileContent.init(cellID: ProfileCellId.genderCell, firstOptionText: "Hombre", secondOptionText: "Mujer", firstOption: UserOption.getOptionWith(gender: gender)),
                ProfileContent.init(cellID: ProfileCellId.simpleCell, labelText: "Delete credit cards", actionBlock: {
                    let removeCardVC = RemoveCardTableViewController ()
                    parent.navigationController?.pushViewController(removeCardVC, animated: true)
                }),
                ProfileContent.init(cellID: ProfileCellId.simpleCell, labelText: "Cerrar sesión", actionBlock: {
                    Hamp.Auth.signOut(onSucced: {
                        let window = (UIApplication.shared.delegate as! AppDelegate).window
                        window?.rootViewController?.removeFromParentViewController()
                        let storyboard = UIStoryboard.init(name: "Login", bundle: Bundle.main)
                        let viewController = storyboard.instantiateViewController(withIdentifier: loginViewControllerIdentifier)
                        window?.rootViewController = viewController
                        window?.makeKeyAndVisible()
                    }) { (error) in
                        print("Error login out: ", error)
                    }
                }),
                ProfileContent.init(cellID: ProfileCellId.infoCell, labelText: "Info", actionBlock: {
                    let url = URL (string: "https://www.google.es")
                    let safariController = SFSafariViewController (url: url!)
                    parent.present (safariController, animated: true, completion: nil)
                })
            ]
        ]
    }
}
