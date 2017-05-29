//
//  FriendShip.swift
//  Stalker
//
//  Created by m2sar on 29/05/17.
//  Copyright © 2017 m2sar. All rights reserved.
//

import Foundation

struct FriendShip {
    
    // MARK: Properties
    
    var id: String?
    var emailSource: String?
    var emailDest: String?
    var isAccepted: Bool?
    
    // MARK: Initialization
    
    init(id: String? = nil, emailSource: String? = nil, emailDest: String? = nil, isAccepted: Bool? = nil) {
        self.id = id
        self.emailSource = emailSource
        self.emailDest = emailDest
        self.isAccepted = isAccepted
    }
    
    init(json: [String: Any]) {
        self.init(id: json["id"] as? String,
                  emailSource: json["emailSource"] as? String,
                  emailDest: json["emailDest"] as? String,
                  isAccepted: json["isAccepted"] as? Bool)
    }
    
    // MARK: Methods
    
    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        
        if self.id != nil {
            dictionary["id"] = self.id
        }
        if self.emailSource != nil {
            dictionary["emailSource"] = self.emailSource
        }
        if self.emailDest != nil {
            dictionary["emailDest"] = self.emailDest
        }
        if self.isAccepted != nil {
            dictionary["isAccepted"] = self.isAccepted
        }
        
        return dictionary
    }

}
