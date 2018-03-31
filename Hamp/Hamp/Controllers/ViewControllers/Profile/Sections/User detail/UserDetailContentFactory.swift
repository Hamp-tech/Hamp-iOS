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
		let name = ProfileCellContent(title: "Nombre", value: "Joan", jsonKey: "name")
		let surname = ProfileCellContent(title: "Apellido", value: "Molinas", jsonKey: "surname")
		let email = ProfileCellContent(title: "Email", value: "pepito@pepito.com", jsonKey: "email")
		let phone = ProfileCellContent(title: "Teléfono", value: "687307264", jsonKey: "phone")
		let birthday = ProfileCellContent(title: "Fecha de nacimiento", value: "05/05/1994", jsonKey: "birthday")
		let gender = ProfileCellContent(title: "Gender", value: "Male", jsonKey: "gender")
		
		return ProfileTableViewSection(contents: [name, surname, email, phone, birthday, gender])
	}
}


