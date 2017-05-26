//
//  Pin.swift
//  Stalker
//
//  Created by m2sar on 24/05/17.
//  Copyright © 2017 m2sar. All rights reserved.
//

import Foundation
import MapKit

class Pin: NSObject, MKAnnotation{
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String) {
        self.coordinate = coordinate
        self.title = title
    }
    
}
