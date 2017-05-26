//
//  Position.swift
//  Stalker
//
//  Created by m2sar on 26/05/17.
//  Copyright © 2017 m2sar. All rights reserved.
//

import Foundation

struct Position {
    
    // MARK: Properties
    
    var id: String?
    var latitude: Double?
    var longitude: Double?
    var userId: String?
    
    // MARK: Initialization
    
    init() {}
    
    init(id: String? = nil, latitude: Double? = nil, longitude: Double? = nil, userId: String? = nil) {
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
        self.userId = userId
    }
    
    init(json: [String: Any]) {
        self.init(id: json["id"] as? String,
                  latitude: json["latitude"] as? Double,
                  longitude: json["longitude"] as? Double,
                  userId: json["userId"] as? String)
    }
    
}
