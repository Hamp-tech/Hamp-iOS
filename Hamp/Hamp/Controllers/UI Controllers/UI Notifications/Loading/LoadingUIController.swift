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
		NotificationCenter.default.addObserver(self, selector: #selector(_dismiss), name: NSNotification.Name(rawValue: "dismissLoading"), object: nil)
	}
	
	deinit {
		 NotificationCenter.default.removeObserver(self)
	}
}

extension LoadingUIController {
	@objc private func _dismiss() {
		dismiss(animated: false)
	}
}
