//
//  UserDetailContentFactory.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 31/3/18.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import Foundation
import HampKit

struct UserDetailContentFactory {
	static func all() -> [ProfileTableViewSection] {
		return [userFields()]
	}
}

private extension UserDetailContentFactory {
	static func userFields() -> ProfileTableViewSection {
		let user = Hamp.Auth.user
		let name = ProfileCellContent(
			title: "Nombre",
			value: user?.name,
			jsonKey: "name",
			validation: ValidationsFactory.Option.filled,
			input: .text)
		
		let surname = ProfileCellContent(
			title: "Apellido",
			value: user?.surname,
			jsonKey: "surname",
			validation: ValidationsFactory.Option.filled,
			input: .text)
		
		let email = ProfileCellContent(
			title: "Email",
			value: user?.email,
			jsonKey: "email",
			validation: ValidationsFactory.Option.email,
			input: .text)
		
		let phone = ProfileCellContent(
			title: "Teléfono",
			value: user?.phone,
			jsonKey: "phone",
			validation: ValidationsFactory.Option.phone,
			input: .text)
		
		let birthday = ProfileCellContent(
			title: "Cumpleaños",
			value: user?.birthday,
			jsonKey: "birthday",
			input: .date)
		
		let gender = ProfileCellContent(
			title: "Gender",
			value: user?.gender,
			jsonKey: "gender",
			input: .gender)
		
		return ProfileTableViewSection(contents: [name, surname, email, phone, birthday, gender])
	}
}


