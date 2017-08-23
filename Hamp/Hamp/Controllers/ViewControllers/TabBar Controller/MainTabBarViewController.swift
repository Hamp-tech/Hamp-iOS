//
//  MainTabBarViewController.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 14/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if FirstTimeActionsManager.needsExecuteAction(by: .presentNewCreditCard) {
            let vc = UIStoryboard.init(name: "TabBar", bundle: Bundle.main).instantiateViewController(withIdentifier: "newCreditCardViewController")
            viewControllers?.first?.present(vc, animated: true, completion: nil)
            FirstTimeActionsManager.changeFirstTimeState(to: .presentNewCreditCard, executeNextTime: false)
        }
        
      let vc = UIStoryboard.init(name: "TabBar", bundle: Bundle.main).instantiateViewController(withIdentifier: "ratingViewController")
        
        present(vc, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedIndex = 1
    }
}
