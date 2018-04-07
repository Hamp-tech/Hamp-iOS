//
//  LoadingUIController.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 7/4/18.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class LoadingUIController: HampViewController {

	// MARK: - Properties
	@IBOutlet private weak var activityContainerView: UIView!
	@IBOutlet weak var indicator: NVActivityIndicatorView!
	
	// MARK: - Life cycle
	init() {
		super.init(nibName: nil, bundle: nil)
		modalPresentationStyle = .overCurrentContext
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		activityContainerView.alpha = 1
		view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
		indicator.startAnimating()
	}
}

extension LoadingUIController: UINotificable {
	func notification() -> UIView {
		return view
	}
	
	func present(completion: (() -> Void)?) {
		UIView.animate(withDuration: 0.5, animations: { [weak self] in
			self?.activityContainerView.alpha = 1
		}, completion: nil)
	}
	
	func dismiss(completion: (() -> Void)?) {
//		UIView.animate(withDuration: 0.5, animations: { [weak self] in
//			self?.activityContainerView.alpha = 1
//			}, completion: nil)
	}
}
