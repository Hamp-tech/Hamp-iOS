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
        navigationController?.navigationBar.barTintColor = UIColor.white
        addImageToTitle()
        addBottomLayer()
    }
    
    private func addImageToTitle() {
        let image = #imageLiteral(resourceName: "small-bag")
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: 27, height: 34)
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
    
    private func addBottomLayer() {
        let layer = CALayer()
        layer.frame = CGRect(x: 0, y: navigationController!.navigationBar.frame.height - 1, width: navigationController!.navigationBar.frame.width, height: 1)
        layer.backgroundColor = UIColor.darkPink.cgColor
        navigationController!.navigationBar.layer.addSublayer(layer)
    }
}
