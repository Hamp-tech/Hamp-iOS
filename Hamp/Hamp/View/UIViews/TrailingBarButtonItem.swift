//
//  TrailingBarButtonItem.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 18/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class TrailingBarButtonItem: UIView {
    
    //MARK: Properties
    var viewController: UIViewController?
    
    //MARK: Life cycle
    init(with view: UIView) {
        super.init(frame: view.frame)
        backgroundColor = UIColor.clear
        addSubview(view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
