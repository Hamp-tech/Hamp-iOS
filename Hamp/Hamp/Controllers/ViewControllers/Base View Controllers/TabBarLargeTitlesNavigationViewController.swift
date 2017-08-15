//
//  TabBarLargeTitlesNavigationViewController.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 16/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class TabBarLargeTitlesNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 11.0, *) {
            self.navigationBar.prefersLargeTitles = true
        }
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = .white
        self.navigationBar.shadowImage = UIImage.init()
    }
}
