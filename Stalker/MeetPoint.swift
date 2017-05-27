//
//  MeetPoint.swift
//  Stalker
//
//  Created by m2sar on 10/05/17.
//  Copyright © 2017 m2sar. All rights reserved.
//

import UIKit

struct MeetPoint {
    
    // MARK: Properties
    
    var id: String?
    var name: String?
    var address: String?
    var zipCode: String?
    var town: String?
    var latitude: Double?
    var longitude: Double?
    
    // MARK: Initializers
    
    init(id: String? = nil, name: String? = nil, address: String? = nil, zipCode: String? = nil, town: String? = nil, latitude: Double? = nil, longitude: Double? = nil) {
        self.id = id
        self.name = name
        self.address = address
        self.zipCode = zipCode
        self.town = town
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init(json: [String: Any]) {
        self.init(id: json["id"] as? String,
                  name: json["name"] as? String,
                  address: json["address"] as? String,
                  zipCode: json["zipCode"] as? String,
                  town: json["town"] as? String,
                  latitude: json["latitude"] as? Double,
                  longitude: json["longitude"] as? Double)
    }
    
    // MARK: Methods
    
    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        
        if self.id != nil {
            dictionary["id"] = self.id
        }
        if self.name != nil {
            dictionary["name"] = self.name
        }
        if self.address != nil {
            dictionary["address"] = self.address
        }
        if self.zipCode != nil {
            dictionary["zipCode"] = self.zipCode
        }
        if self.town != nil {
            dictionary["town"] = self.town
        }
        if self.latitude != nil {
            dictionary["latitude"] = self.latitude
        }
        if self.longitude != nil {
            dictionary["longitude"] = self.longitude
        }
        
        return dictionary
    }
    
}
