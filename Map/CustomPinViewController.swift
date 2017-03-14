//
//  CustomPinViewController.swift
//  Map
//
//  Created by John Lima on 13/03/17.
//  Copyright © 2017 limadeveloper. All rights reserved.
//
// https://www.youtube.com/watch?v=rUeHFERIsaY

import UIKit
import MapKit
import CoreLocation

class CustomPinViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet fileprivate weak var map: MKMapView?
    
    fileprivate let manager = CLLocationManager()
    
    var mapType: MapType?
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setMap()
        updateUI()
    }
    
    // MARK: - Actions
    fileprivate func setMap() {
        map?.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
    }
    
    fileprivate func updateUI() {
        guard let title = mapType?.name else { return }
        navigationItem.title = title
    }
}

extension CustomPinViewController: CLLocationManagerDelegate, MKMapViewDelegate {

    func pointButtonClicked() {
        print("button clicked")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .denied:
            Alert.enableLocation(target: self)
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.first else { return }
        
        let span = MKCoordinateSpanMake(0.01, 0.01)
        let userLocation = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region = MKCoordinateRegionMake(userLocation, span)
        
        map?.setRegion(region, animated: true)
        map?.showsUserLocation = true
        
        let point = MKPointAnnotation()
        point.coordinate = location.coordinate
        point.title = "Yoda"
        point.subtitle = "I'm here"
        
        map?.addAnnotation(point)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if !(annotation is MKUserLocation) {
            
            let identifier = "cell"
            var view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            guard view != nil else {
                
                view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view?.canShowCallout = true
                view?.image = #imageLiteral(resourceName: "Yoda")
                
                let button = UIButton(type: .detailDisclosure)
                button.addTarget(self, action: #selector(pointButtonClicked), for: .touchUpInside)
                
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
                imageView.image = #imageLiteral(resourceName: "Jedi")
                imageView.contentMode = .scaleAspectFit
                imageView.clipsToBounds = true
                
                view?.leftCalloutAccessoryView = imageView
                view?.rightCalloutAccessoryView = button
                
                return view
            }
            
            view?.annotation = annotation
            
            return view
        }
        
        return nil
    }
}
