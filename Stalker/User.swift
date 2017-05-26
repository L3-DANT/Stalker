//
//  Friend.swift
//  Stalker
//
//  Created by m2sar on 04/05/17.
//  Copyright © 2017 m2sar. All rights reserved.
//

import UIKit

class User: NSObject {
    
    // MARK: Properties
    
    var id: String?
    var name: String?
    var email: String?
    var password: String?
    var token: String?
    var lastPosition: String?
    
    // MARK: Initialization
    
    init(id: String? = nil, name: String? = nil, email: String? = nil, password: String? = nil, token: String? = nil, lastPosition: String? = nil) {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
        self.token = token
        self.lastPosition = lastPosition
    }
    
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
