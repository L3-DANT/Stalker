//
//  Service.swift
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
    
    static func getMeetPoints() throws -> [MeetPoint] {
        var meetpoints: [MeetPoint]
        try getMeetPointsRequest(completionHandler: { (result, error) in
            guard error == nil else {
                print("ERROR: getMeetPointsRequest")
                return
            }
            meetpoints = result
        })
        return meetpoints
    }
    
    static func getMeetPointsRequest(completionHandler: @escaping ([MeetPoint], Error?) -> Void) throws {
        
        let user = User(name: "alice", lastPosition: Position(latitude:0.0, longitude:0.0))
        let json = try? JSONSerialization.data(withJSONObject: user)
        
        // set up session
        //        let config = URLSessionConfiguration.default
        //        let session = URLSession(configuration: config)
        let session = URLSession.shared
        
        var request = URLRequest(url: URL(string: "http://35.187.15.102:8080/")!)
        //        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringCacheData
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // TODO: add token
        
        request.httpBody = json
        
        let task = session.dataTask(with: request, completionHandler: {(data, response, error) in
            guard error == nil else {
                print("ERROR: POST on /todos/1")
                print(error!)
                return
            }
            guard let data = data else {
                print("ERROR: did not receive data")
                return
            }
            do {
                guard let result = try JSONSerialization.jsonObject(with: data) as? [[String : Any]] else {
                    print("ERROR: trying to convert data to JSON")
                    return
                }
                var meetpoints = [MeetPoint]()
                for meetpoint in result {
                    meetpoints.append(MeetPoint(json: meetpoint))
                }
                completionHandler(meetpoints, <#Error?#>)
            }
            catch {
                print("ERROR: trying to convert data to JSON")
            }
        })
        task.resume()
    }
    
}
