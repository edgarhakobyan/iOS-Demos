//
//  Location.swift
//  ToDoApp
//
//  Created by Edgar on 07.02.21.
//

import Foundation
import CoreLocation

struct Location {
    let name: String
    let coordinates: CLLocationCoordinate2D?
    
    init(name: String, coordinates: CLLocationCoordinate2D? = nil) {
        self.name = name
        self.coordinates = coordinates
    }
}

extension Location: Equatable {
    static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.coordinates?.latitude == rhs.coordinates?.latitude &&
            lhs.coordinates?.longitude == rhs.coordinates?.longitude &&
            lhs.name == rhs.name
    }
}
