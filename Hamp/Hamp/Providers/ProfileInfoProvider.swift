//
//  ProfileInfoProvider.swift
//  Hamp
//
//  Created by Aleix Baggerman on 20/10/2017.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import Foundation

struct ProfileInfoProvider: ProfileTableProvider {
    
    private let content: [[UserContent]] = [
        [
            ProfileContent.init(cellID: ProfileCellId.textFieldCell, labelText: "Nombre", textFieldText: "Judith", firstOptionText: "", secondOptionText: "", firstOption: .none),
            ProfileContent.init(cellID: ProfileCellId.textFieldCell, labelText: "Apellido", textFieldText: "Moreno Navarro", firstOptionText: "", secondOptionText: "", firstOption: .none),
            ProfileContent.init(cellID: ProfileCellId.textFieldCell, labelText: "E-mail", textFieldText: "judithmoreno@gmail.com", firstOptionText: "", secondOptionText: "", firstOption: .none),
            ProfileContent.init(cellID: ProfileCellId.textFieldCell, labelText: "Teléfono", textFieldText: "666 666 666", firstOptionText: "", secondOptionText: "", firstOption: .none),
            ProfileContent.init(cellID: ProfileCellId.dateCell, labelText: "Fecha de nacimiento", textFieldText: "22/33/4444", firstOptionText: "", secondOptionText: "", firstOption: .none),
            ProfileContent.init(cellID: ProfileCellId.genderCell, labelText: "", textFieldText: "", firstOptionText: "Hombre", secondOptionText: "Mujer", firstOption: .leftOption),
            ProfileContent.init(cellID: ProfileCellId.pickUpCell, labelText: "Recogida", textFieldText: "", firstOptionText: "Mañana", secondOptionText: "Tarde", firstOption: .rightOption),
            ProfileContent.init(cellID: ProfileCellId.switchCell, labelText: "Valorar Hamp", textFieldText: "", firstOptionText: "", secondOptionText: "", firstOption: .leftOption),
            ProfileContent.init(cellID: ProfileCellId.switchCell, labelText: "Notificaciones activadas", textFieldText: "", firstOptionText: "", secondOptionText: "", firstOption: .leftOption),
            ProfileContent.init(cellID: ProfileCellId.simpleCell, labelText: "Cerrar sesión", textFieldText: "", firstOptionText: "", secondOptionText: "", firstOption: .none),
            ProfileContent.init(cellID: ProfileCellId.infoCell, labelText: "Info", textFieldText: "", firstOptionText: "", secondOptionText: "", firstOption: .none)
        ]
    ]
    
    func numberOfSections() -> Int {
        return content.count
    }
    
    func numberOfItems(at section: Int) -> Int {
        return content[section].count
    }
    
    func content(at indexPath: IndexPath) -> UserContent? {
        return content [indexPath.section][indexPath.row]
    }
}
