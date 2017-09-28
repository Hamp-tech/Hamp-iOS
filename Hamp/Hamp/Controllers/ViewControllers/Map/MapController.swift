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
    
    @IBOutlet weak var mapView: CustomMapView!
    
    override func viewDidLoad() {
        setupMapView ()
        loadMapLocation (location: CLLocation(latitude: 41.215590, longitude: 1.527245), pinTitle: "HampOffice", locationName: "El Vendrell", discipline: "Office")
    }
    
    fileprivate func setupMapView () {
        mapView.isScrollEnabled = false
        mapView.delegate = self
    }
    
    func loadMapLocation (location: CLLocation, pinTitle: String, locationName: String, discipline: String) {
        mapView.centerMapOnLocation(location: location)
        let artwork = MapArtWork(title: pinTitle, locationName: locationName, discipline: discipline, coordinate: location.coordinate)
        mapView.addAnnotation(artwork)
    }
}

extension MapController: MKMapViewDelegate {
    private func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if let annotation = annotation as? MapArtWork {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
            }
            return view
        }
        return nil
    }
}
