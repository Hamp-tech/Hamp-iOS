//
//  UserDetailContentFactory.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 31/3/18.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import Foundation

struct UserDetailContentFactory {
	static func all() -> [ProfileTableViewSection] {
		return [userFields()]
	}
}

private extension UserDetailContentFactory {
	static func userFields() -> ProfileTableViewSection {
		let name = ProfileCellContent(title: "Nombre", value: "Joan")
		let surname = ProfileCellContent(title: "Apellido", value: "Molinas")
		let email = ProfileCellContent(title: "Email", value: "pepito@pepito.com")
		let phone = ProfileCellContent(title: "Teléfono", value: "687307264")
		let birthday = ProfileCellContent(title: "Fecha de nacimiento", value: "05/05/1994")
		let gender = ProfileCellContent(title: "Gender", value: "Male")
		
		return ProfileTableViewSection(contents: [name, surname, email, phone, birthday, gender])
	}
}


