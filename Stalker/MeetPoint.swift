//
//  MeetPoint.swift
//  Stalker
//
//  Created by m2sar on 10/05/17.
//  Copyright © 2017 m2sar. All rights reserved.
//

import UIKit

class MeetPoint {
    
    // MARK: Properties
    
    var id: CLong?
    var name: String?
    var address: String?
    var postalCode : String?
    var city: String?
    var latitude: Double?
    var longitude: Double?
    
    // MARK: Initialization
    
    init(id:CLong?=nil, name:String?=nil, address:String?=nil, postalCode:String?=nil, city:String?=nil, latitude:Double?=nil, longitude:Double?=nil) {
        self.id = id
        self.name = name
        self.address = address
        self.postalCode = postalCode
        self.city = city
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init() {}

}
