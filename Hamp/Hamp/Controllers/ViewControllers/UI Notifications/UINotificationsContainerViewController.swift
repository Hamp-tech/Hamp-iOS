//
//  UINotificationsContainerViewController.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 22/3/18.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class UINotificationsContainerViewController: HampViewController {
	
	// MARK: - Properties
	private var notification: UINotificable!
	
	
	// MARK: - Life cycle
	init(notification: UINotificable) {
		super.init(nibName: nil, bundle: nil)
		self.notification = notification
		modalPresentationStyle = .overCurrentContext
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func loadView() {
		let v = UIView(frame: UIScreen.main.bounds)
		v.backgroundColor = UIColor(white: 0, alpha: 0.6)
		
		let tap = UITapGestureRecognizer(target: self, action: #selector(dismissView(sender:)))
		v.addGestureRecognizer(tap)
		
		self.view = v
		
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let noti = notification.notification()
		noti.frame = view.bounds
		view.addSubview(noti)
	}
}

private extension UINotificationsContainerViewController {
	@objc private func dismissView(sender: UITapGestureRecognizer) {
		dismiss(animated: true)
	}
}
