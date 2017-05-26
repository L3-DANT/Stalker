//
//  Friend.swift
//  Stalker
//
//  Created by m2sar on 04/05/17.
//  Copyright © 2017 m2sar. All rights reserved.
//

import UIKit
import MapKit

class Friend {

    var name: String
    var position: CLLocationCoordinate2D
    
    
    init(name: String, position: CLLocationCoordinate2D){
        self.name = name
        self.position = position
    }
}
