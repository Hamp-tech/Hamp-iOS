//
//  StoresViewController.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 10/10/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class StoresViewController: PulleyViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        (draggableContentViewController as! StoresListViewController).delegate = self
    }
}

extension StoresViewController: StoresListViewControllerDelegate {
    func storesList(storesList: StoresListViewController, didBeginEditing: UITextField) {
        guard draggablePosition != .open else { return  }
        setDraggablePosition(position: .open, animated: true)
    }
    
    func storesList(storesList: StoresListViewController, didEndEditing: UITextField) {
        guard draggablePosition != .collapsed else {return}
        setDraggablePosition(position: .collapsed, animated: true)
    }

}
