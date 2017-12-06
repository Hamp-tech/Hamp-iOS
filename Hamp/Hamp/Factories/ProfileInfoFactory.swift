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
    static func createProfileInfo (user: HampUser) -> [[UserContent]] {
        return [
            [
                ProfileContent.init(cellID: ProfileCellId.textFieldCell, labelText: "Nombre", textFieldText: user.name),
                ProfileContent.init(cellID: ProfileCellId.textFieldCell, labelText: "Apellido", textFieldText: user.surname),
                ProfileContent.init(cellID: ProfileCellId.textFieldCell, labelText: "E-mail", textFieldText: user.mail),
                ProfileContent.init(cellID: ProfileCellId.textFieldCell, labelText: "Teléfono", textFieldText: user.phone),
                ProfileContent.init(cellID: ProfileCellId.dateCell, labelText: "Fecha de nacimiento", textFieldText: user.birthday!),
                ProfileContent.init(cellID: ProfileCellId.genderCell, firstOptionText: "Hombre", secondOptionText: user.gender!, firstOption: .leftOption),
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
