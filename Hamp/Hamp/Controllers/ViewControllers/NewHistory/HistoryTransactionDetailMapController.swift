//
//  HistoryTransactionDetailMapController.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 25/3/18.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import UIKit
import MapKit

class HistoryTransactionDetailMapController: HampViewController {
	
	// MARK: - Properties
	private var point: DBPoint!
	private lazy var mapView: MKMapView = {
		let mapView = MKMapView()
		mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.isScrollEnabled = false
		mapView.center(on: CLLocation(latitude: point.location!.latitude, longitude: point.location!.longitude), distance: 200)
		return mapView
	}()
	
	// MARK: - Life cycle
	init(point: DBPoint) {
		super.init(nibName: nil, bundle: nil)
		self.point = point
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		view.addSubview(mapView)
		
		NSLayoutConstraint.activate([
			mapView.leftAnchor.constraint(equalTo: view.leftAnchor),
			mapView.topAnchor.constraint(equalTo: view.topAnchor),
			mapView.rightAnchor.constraint(equalTo: view.rightAnchor),
			mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
			])
    }
}
