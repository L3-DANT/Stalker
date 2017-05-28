//
//  SerializationError.swift
//  Stalker
//
//  Created by m2sar on 26/05/17.
//  Copyright © 2017 m2sar. All rights reserved.
//

import Foundation

enum SerializationError: Error {
    case Data
    case JSONObject(Error)
//    case Missing(String)
//    case Invalid(String, Any)
}
