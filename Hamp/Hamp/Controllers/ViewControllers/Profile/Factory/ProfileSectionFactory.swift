//
//  ProfileSectionFactory.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 28/3/18.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import Foundation

struct ProfileSectionFactory {
	
	static func all() -> [ProfileTableViewSection] {
		return [userInformation(), conditions()]
	}
}

private extension ProfileSectionFactory {
	static func userInformation() -> ProfileTableViewSection {
//		let name = ProfileCellContent(title: "Nombre", value: "Joan")
//		let surname = ProfileCellContent(title: "Apellido", value: "Molinas")
//		let email = ProfileCellContent(title: "Email", value: "pepito@pepito.com")
//		let phone = ProfileCellContent(title: "Telénono", value: "687307264")
//		let birthday = ProfileCellContent(title: "Fecha de nacimiento", value: "05/05/1994")
//		let gender = ProfileCellContent(title: "Gender", value: "Male")
		
		let userInfo = ProfileCellContent(title: "Detalles personales", navigation: UserDetailNavigation())
		let cards = ProfileCellContent(title: "Métodos de pago")
		return ProfileTableViewSection(title: "Perfil", contents: [userInfo, cards])
	}
	
	static func conditions() -> ProfileTableViewSection {
		let useConditions = ProfileCellContent(title: "Condiciones de uso")
		
		return ProfileTableViewSection(title: "Condiciones", contents: [useConditions])
	}
}
