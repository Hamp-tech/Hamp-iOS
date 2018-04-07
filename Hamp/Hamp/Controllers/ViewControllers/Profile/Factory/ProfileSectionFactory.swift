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
		return [userInformation(), payment(), conditions()]
	}
}

private extension ProfileSectionFactory {
	static func userInformation() -> ProfileTableViewSection {		
		let userInfo = ProfileCellContent(title: "Detalles personales", navigation: UserDetailNavigation())
		let passwords = ProfileCellContent(title: "Cambiar contraseña", navigation: ChangePasswordNavigator())
		return ProfileTableViewSection(title: "Perfil", contents: [userInfo, passwords])
	}
	
	static func payment() -> ProfileTableViewSection {
		let cards = ProfileCellContent(title: "Targetas de crédito", navigation: CreditCardsNavigation())
		return ProfileTableViewSection(title: "Métodos de pago", contents: [cards])
	}
	
	static func conditions() -> ProfileTableViewSection {
		let useConditions = ProfileCellContent(title: "Condiciones de uso")
		
		return ProfileTableViewSection(title: "Condiciones", contents: [useConditions])
	}
}
