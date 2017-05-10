//
//  MeetPoint.swift
//  Stalker
//
//  Created by m2sar on 10/05/17.
//  Copyright © 2017 m2sar. All rights reserved.
//

import UIKit

class MeetPoint {
    
    var name: String
    var address: String
    var latitude: Double
    var longitude: Double
    var favorite: Bool
    
    init(name: String, address: String, latitude: Double, longitude: Double, favorite: Bool){
        self.name = name
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.favorite = favorite
    }

}
