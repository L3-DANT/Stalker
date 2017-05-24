//
//  Friend.swift
//  Stalker
//
//  Created by m2sar on 04/05/17.
//  Copyright © 2017 m2sar. All rights reserved.
//

import UIKit

class User {

    var id: CLong
    var name: String
    var email: String
    var position: String
    
    
    init(id: CLong, name: String, email: String, position: String){
        self.id = id
        self.name = name
        self.email = email
        self.position = position
    }
}
