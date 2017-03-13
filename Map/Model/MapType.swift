//
//  MapType.swift
//  Map
//
//  Created by John Lima on 13/03/17.
//  Copyright © 2017 limadeveloper. All rights reserved.
//

import Foundation

struct MapType {
    
    var id: Int?
    var name: String?
    var identifier: String?
    
    init(id: Int, name: String, identifier: String) {
        self.id = id
        self.name = name
        self.identifier = identifier
    }
}

extension MapType {
    
    static func getData() -> [MapType] {
        return [
            MapType(id: 1, name: "User Location", identifier: Segue.userLocation),
            MapType(id: 2, name: "Custom Pin", identifier: Segue.customPin)
        ]
    }
}
