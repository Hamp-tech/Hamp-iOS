//
//  TabBarLargeTitlesNavigationViewController.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 16/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class TabBarLargeTitlesNavigationViewController: UINavigationController {
	
	// MARK: Properties
	var activityIndicator: UIActivityIndicatorView?
	var needsActivityIndicator: Bool = false {
		didSet {
			if needsActivityIndicator {
				_addActivityIndicator()
			} else {
				activityIndicator?.stopAnimating()
				activityIndicator?.removeFromSuperview()
				activityIndicator = nil
			}
		}
	}
	
	// MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            navigationBar.prefersLargeTitles = true
        }
        
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = .white
        navigationBar.shadowImage = UIImage.init()
    }
	
	// MARK: - API
	func startActivityIndicator() {
		guard needsActivityIndicator else { return }
		activityIndicator?.startAnimating()
	}
	
	func stopActivityIndicator() {
		guard needsActivityIndicator else { return }
		activityIndicator?.stopAnimating()
	}
}

private extension TabBarLargeTitlesNavigationViewController {
	func _addActivityIndicator() {
		activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
		activityIndicator?.hidesWhenStopped = true
		
		let item = UIBarButtonItem(customView: activityIndicator!)
		if var items = navigationItem.rightBarButtonItems {
			items.insert(item, at: 0)
		} else {
			navigationItem.rightBarButtonItem = item
		}
	}
}


