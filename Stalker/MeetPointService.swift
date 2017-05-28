//
//  MeetPointService.swift
//  Stalker
//
//  Created by m2sar on 26/05/17.
//  Copyright © 2017 m2sar. All rights reserved.
//

import Foundation

final class MeetPointService {
    
    // MARK: Initializers
    
    private init() {}
    
    // MARK: Methods
    typealias MeetPointsBuilder = () throws -> [MeetPoint]
    static func getAll(completion: @escaping (MeetPointsBuilder) -> Void) {
        let user = User(token: "0")
        
        // set up session
        //        let config = URLSessionConfiguration.default
        //        let session = URLSession(configuration: config)
        let session = URLSession.shared
        
        var request = URLRequest(url: URL(string: "http://35.187.15.102:8080/api/meetpoint/test/all")!)
        //        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringCacheData
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        // TODO: set token
        request.addValue(user.token!, forHTTPHeaderField: "Token")
        
        let task = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            completion({ MeetPointsBuilder in
                if let error = error {
                    throw HttpRequestError.Default(error)
                }
                if let httpResponse = response as? HTTPURLResponse {
                    guard httpResponse.statusCode == 200 else {
                        throw HttpRequestError.StatusCode(httpResponse.statusCode)
                    }
                }
                guard let data = data else {
                    throw HttpRequestError.EmptyData
                }
                guard let result = try JSONSerialization.jsonObject(with: data) as? [[String : Any]] else {
                    throw SerializationError.Default
                }
                var meetpoints = [MeetPoint]()
                for meetpoint in result {
                    meetpoints.append(MeetPoint(json: meetpoint))
                }
                return meetpoints
            })
        })
        task.resume()
    }
    
}
