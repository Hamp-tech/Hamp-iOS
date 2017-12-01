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
                ProfileContent.init(cellID: ProfileCellId.textFieldCell, labelText: "Nombre", textFieldText: user.name, firstOptionText: "", secondOptionText: "", firstOption: .none),
                ProfileContent.init(cellID: ProfileCellId.textFieldCell, labelText: "Apellido", textFieldText: user.surname, firstOptionText: "", secondOptionText: "", firstOption: .none),
                ProfileContent.init(cellID: ProfileCellId.textFieldCell, labelText: "E-mail", textFieldText: user.mail, firstOptionText: "", secondOptionText: "", firstOption: .none),
                ProfileContent.init(cellID: ProfileCellId.textFieldCell, labelText: "Teléfono", textFieldText: user.phone, firstOptionText: "", secondOptionText: "", firstOption: .none),
                ProfileContent.init(cellID: ProfileCellId.dateCell, labelText: "Fecha de nacimiento", textFieldText: user.birthday!, firstOptionText: "", secondOptionText: "", firstOption: .none),
                ProfileContent.init(cellID: ProfileCellId.genderCell, labelText: "", textFieldText: "", firstOptionText: "Hombre", secondOptionText: user.gender!, firstOption: .leftOption),
                ProfileContent.init(cellID: ProfileCellId.pickUpCell, labelText: "Recogida", textFieldText: "", firstOptionText: "Mañana", secondOptionText: "Tarde", firstOption: .rightOption),
                ProfileContent.init(cellID: ProfileCellId.switchCell, labelText: "Valorar Hamp", textFieldText: "", firstOptionText: "", secondOptionText: "", firstOption: .leftOption),
                ProfileContent.init(cellID: ProfileCellId.switchCell, labelText: "Notificaciones activadas", textFieldText: "", firstOptionText: "", secondOptionText: "", firstOption: .leftOption),
                ProfileContent.init(cellID: ProfileCellId.simpleCell, labelText: "Cerrar sesión", textFieldText: "", firstOptionText: "", secondOptionText: "", firstOption: .none),
                ProfileContent.init(cellID: ProfileCellId.infoCell, labelText: "Info", textFieldText: "", firstOptionText: "", secondOptionText: "", firstOption: .none)
            ]
        ]
    }
}
