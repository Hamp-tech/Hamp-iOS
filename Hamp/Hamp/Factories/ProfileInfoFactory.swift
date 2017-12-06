//
//  ProfileInfoFactory.swift
//  Hamp
//
//  Created by Aleix Baggerman on 30/11/2017.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation
import HampKit

struct ProfileInfoFactory {
    static func createProfileInfo (user: HampUser, parent: UIViewController? = nil) -> [[UserContent]] {
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
//                        picker.delegate = self
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
                    
                    datePicker.show(inVC: parent!)
                }),
                ProfileContent.init(cellID: ProfileCellId.genderCell, firstOptionText: "Hombre", secondOptionText: "Mujer", firstOption: UserOption.getOptionWith(gender: "F")),
                ProfileContent.init(cellID: ProfileCellId.pickUpCell, labelText: "Recogida", firstOptionText: "Mañana", secondOptionText: "Tarde", firstOption: .rightOption),
                ProfileContent.init(cellID: ProfileCellId.switchCell, labelText: "Valorar Hamp", firstOption: .leftOption),
                ProfileContent.init(cellID: ProfileCellId.switchCell, labelText: "Notificaciones activadas", firstOption: .leftOption),
                ProfileContent.init(cellID: ProfileCellId.simpleCell, labelText: "Cerrar sesión", actionBlock: {
                    Hamp.Auth.signOut(onSucced: {
                        let window = (UIApplication.shared.delegate as! AppDelegate).window
                        window?.rootViewController?.removeFromParentViewController()
                        let storyboard = UIStoryboard.init(name: "Login", bundle: Bundle.main)
                        let viewController = storyboard.instantiateViewController(withIdentifier: loginViewControllerIdentifier)
                        window?.rootViewController = viewController
                        window?.makeKeyAndVisible()
                    }) { (error) in
                        
                    }
                }),
                ProfileContent.init(cellID: ProfileCellId.infoCell, labelText: "Info")
            ]
        ]
    }
}
