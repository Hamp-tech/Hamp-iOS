//
//  MapController.swift
//  Hamp
//
//  Created by Aleix Baggerman on 28/9/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit
import MapKit

class MapController: PulleyChildViewController {
    
    private var mapView: CustomMapView!
    private var point: DBPoint!
    
    init (point: DBPoint) {
        super.init(nibName: nil, bundle: nil)
        self.point = point
        mapView = CustomMapView.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView ()
        guard let location = point.location else {return}
        loadMapLocation (location: CLLocation(latitude: location.latitude, longitude: location.longitude), pinTitle: location.name, locationName: point.city, discipline: point.address)
    }
    
    fileprivate func setupMapView () {
        mapView.frame = view.frame
        view.addSubview(mapView)
        mapView.isScrollEnabled = false        
    }
    
    private func loadMapLocation (location: CLLocation, pinTitle: String, locationName: String, discipline: String) {
        mapView.centerMapOnLocation(location: location)
        let artwork = MapArtWork(title: pinTitle, locationName: locationName, discipline: discipline, coordinate: location.coordinate)
        mapView.addAnnotation(artwork)
    }
    
    
}
