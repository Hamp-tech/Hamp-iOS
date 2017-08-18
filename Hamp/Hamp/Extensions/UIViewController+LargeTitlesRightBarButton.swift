//
//  UIViewController+LargeTitlesRightBarButton.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 16/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

extension UIViewController {
    func addRightBarButtonWhenLargeTitles(rightButton: TrailingBarButtonItem) {
        
        guard let nav = navigationController else { return }
        
        let previousButton = nav.navigationBar.subviews.filter { $0.isKind(of: TrailingBarButtonItem.self) }.first
        nav.navigationBar.addSubview(rightButton)
        
        let navigationBar = nav.navigationBar
        
        let targetView: UIView!
        let anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>
        let constant: CGFloat = -15
        
        if let pb = previousButton {
            targetView = pb
            anchor = targetView.leftAnchor
        } else {
            targetView = navigationBar
            anchor = targetView.rightAnchor
        }
        
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rightButton.rightAnchor.constraint(equalTo: anchor, constant: constant),
            rightButton.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: constant),
            rightButton.widthAnchor.constraint(equalToConstant: rightButton.frame.width),
            rightButton.heightAnchor.constraint(equalToConstant: rightButton.frame.height)
            ])
    }
    
    func hideNavigationBarRightButtons() {
        navigationController?.navigationBar.subviews.filter{ $0.isKind(of: TrailingBarButtonItem.self)}.forEach { $0.alpha = 0 }
    }
    
    func showNavigationBarRightButtons() {
        navigationController?.navigationBar.subviews.filter{ $0.isKind(of: TrailingBarButtonItem.self)}.forEach { $0.alpha = 1 }
    }
}
