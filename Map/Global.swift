//
//  Global.swift
//  Map
//
//  Created by John Lima on 13/03/17.
//  Copyright © 2017 limadeveloper. All rights reserved.
//

import Foundation
import UIKit

struct Segue {
    static let userLocation = "UserLocation"
    static let customPin = "CustomPin"
    static let backgroundLocation = "BackgroundLocation" 
}

struct Message {
    static let ok = "Ok"
    static let no = "No"
    static let cancel = "Cancel"
    static let hey = "Hey"
    static let alert = "Alert"
    static let enableLocation = "To use location services, you need to enable it on settings."
}

struct Alert {
    
    static func enableLocation(target: AnyObject) {
        
        let no = UIAlertAction(title: Message.no, style: .destructive, handler: nil)
        
        let yes = UIAlertAction(title: Message.ok, style: .default) { action in
            guard let url = URL(string: UIApplicationOpenSettingsURLString) else { return }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
        let alert = UIAlertController(title: Message.alert, message: Message.enableLocation, preferredStyle: .alert)
        
        alert.addAction(no)
        alert.addAction(yes)
        
        target.present(alert, animated: true, completion: nil)
    }
}
