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
            navigationBar.prefersLargeTitles = true
        }
        
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = .white
        navigationBar.shadowImage = UIImage.init()
    }
    
//    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
//        navigationBar.subviews.filter{ $0.isKind(of: UIButton.self)}.forEach { $0.alpha = 0 }
//        super.pushViewController(viewController, animated: animated)
//    }
//    
//    
//    override func popViewController(animated: Bool) -> UIViewController? {
//        let vc = super.popViewController(animated: animated)
//        navigationBar.subviews.filter{ $0.isKind(of: UIButton.self)}.forEach { $0.alpha = 1 }
//        return vc
//    }
}

