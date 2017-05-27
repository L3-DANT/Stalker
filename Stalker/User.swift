//
//  Friend.swift
//  Stalker
//
//  Created by m2sar on 04/05/17.
//  Copyright © 2017 m2sar. All rights reserved.
//

import UIKit

struct User {
    
    // MARK: Properties
    
    var id: String?
    var name: String?
    var email: String?
    var password: String?
    var token: String?
    var lastPosition: Position?
    
    // MARK: Initialization
    
    init(id: String? = nil, name: String? = nil, email: String? = nil, password: String? = nil, token: String? = nil, lastPosition: Position? = nil) {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
        self.token = token
        self.lastPosition = lastPosition
    }
    
    init(json: [String: Any]) {
        self.init(id: json["id"] as? String,
                  name: json["name"] as? String,
                  email: json["email"] as? String,
                  token: json["token"] as? String)
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
        if self.email != nil {
            dictionary["email"] = self.email
        }
        if self.password != nil {
            dictionary["password"] = self.password
        }
        if self.token != nil {
            dictionary["token"] = self.token
        }
        if self.lastPosition != nil {
            dictionary["lastPosition"] = self.lastPosition
        }
        
        return dictionary
    }
    
}
