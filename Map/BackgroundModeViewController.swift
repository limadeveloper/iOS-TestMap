//
//  BackgroundModeViewController.swift
//  Map
//
//  Created by John Lima on 14/03/17.
//  Copyright © 2017 limadeveloper. All rights reserved.
//
// https://www.raywenderlich.com/143128/background-modes-tutorial-getting-started

import UIKit
import CoreLocation
import MapKit

class BackgroundModeViewController: UIViewController {

    // MARK - Properties
    @IBOutlet var mapView: MKMapView?
    
    fileprivate var locations = [MKPointAnnotation]()
    fileprivate let manager = CLLocationManager()
    
    var mapType: MapType?
    
    // MARK - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setMap()
        updateUI()
    }

    // MARK - Actions
    fileprivate func setMap() {
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        manager.delegate = self
        manager.requestAlwaysAuthorization()
    }
    
    fileprivate func updateUI() {
        guard let title = mapType?.name else { return }
        navigationItem.title = title
    }
}

extension BackgroundModeViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways:
            manager.startUpdatingLocation()
        case .notDetermined:
            manager.requestAlwaysAuthorization()
        case .denied, .authorizedWhenInUse:
            Alert.enableLocation(target: self)
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let mostRecentLocation = locations.last else { return }
        
        // Add another annotation to the map.
        let annotation = MKPointAnnotation()
        annotation.coordinate = mostRecentLocation.coordinate
        
        // Also add to our map so we can remove old values later
        self.locations.append(annotation)
        
        // Remove values if the array is too big
        while self.locations.count > 100 {
            
            let annotationToRemove = self.locations.first!
            self.locations.remove(at: 0)
            
            // Also remove from the map
            mapView?.removeAnnotation(annotationToRemove)
        }
        
        if UIApplication.shared.applicationState == .active {
            mapView?.showAnnotations(self.locations, animated: true)
        }else {
            print("App is backgrounded. New location is %@", mostRecentLocation)
        }
    }
}
