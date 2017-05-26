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
    var latitude: String?
    var longitude: String?
    var userId: String?
    
    // MARK: Initialization
    
    init() {}
    
    init(id: String? = nil, latitude: String? = nil, longitude: String? = nil, userId: String? = nil) {
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
        self.userId = userId
    }
    
    init(json: [String: Any]) {
        self.init(id: json["id"] as? String,
                  latitude: json["latitude"] as? String,
                  longitude: json["longitude"] as? String,
                  userId: json["userId"] as? String)
    }
    
}
