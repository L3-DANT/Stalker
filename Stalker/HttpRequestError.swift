//
//  HttpRequestError.swift
//  Stalker
//
//  Created by kvin on 27/05/2017.
//  Copyright © 2017 m2sar. All rights reserved.
//

import Foundation

enum HttpRequestError: Error {
    case Default(Error)
    case EmptyData
    case StatusCode(Int)
}
