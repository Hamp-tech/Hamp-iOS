//
//  LogoTitleBaseViewController.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 23/7/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class LogoTitleBaseViewController: HampViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let image = #imageLiteral(resourceName: "SmallBag")
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: 27, height: 34)
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        
        navigationController?.navigationBar.barTintColor = UIColor.white
    }
}
