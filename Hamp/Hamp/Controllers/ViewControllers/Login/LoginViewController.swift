//
//  LoginViewController.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 22/7/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit
import HampKit

class LoginViewController: HampViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        if FirstTimeActionsManager.needsExecuteAction(by: .presentTutorial) {
            let identifier = tutorialViewControllerIdentifier
            let storyboardName = "Tutorial"
            let storyboard = UIStoryboard.init(name: storyboardName, bundle: Bundle.main)
            let viewController = storyboard.instantiateViewController(withIdentifier: identifier)
            present(viewController, animated: false, completion: {
                FirstTimeActionsManager.changeFirstTimeState(to: .presentTutorial, executeNextTime: false)
            })
//        }
    }
}
