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
		let userInfo = ProfileCellContent(title: "Detalles personales", navigation: UserDetailNavigation())
		let cards = ProfileCellContent(title: "Métodos de pago", navigation: CreditCardsNavigation())
		return ProfileTableViewSection(title: "Perfil", contents: [userInfo, cards])
	}
	
	static func conditions() -> ProfileTableViewSection {
		let useConditions = ProfileCellContent(title: "Condiciones de uso")
		
		return ProfileTableViewSection(title: "Condiciones", contents: [useConditions])
	}
}
