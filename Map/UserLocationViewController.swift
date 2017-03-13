//
//  UserLocationViewController.swift
//  Map
//
//  Created by John Lima on 13/03/17.
//  Copyright © 2017 limadeveloper. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class UserLocationViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var map: MKMapView?
    
    let manager = CLLocationManager()
    
    var mapType: MapType?
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setMap()
        updateUI()
    }
    
    // MARK: - Actions
    func setMap() {
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        manager.requestWhenInUseAuthorization()
    }
    
    func updateUI() {
        guard let title = mapType?.name else { return }
        navigationItem.title = title
    }
}

extension UserLocationViewController: CLLocationManagerDelegate {
 
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
        
        print("latitude: \(location.coordinate.latitude)")
        print("longitude: \(location.coordinate.longitude)")
        
        map?.setRegion(region, animated: true)
        map?.showsUserLocation = true
    }
}
