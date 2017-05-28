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
    
    static func getAll(completionHandler: @escaping ([MeetPoint], Error?) -> Void) throws {
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
            guard error == nil else {
                print("ERROR: GET on /api/meetpoint/all")
                print(error!)
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                guard httpResponse.statusCode == 200 else {
                    print("ERROR: httpResponse.statusCode \(httpResponse.statusCode)")
                    return
                }
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
                completionHandler(meetpoints, error)
            }
            catch let error as NSError {
                print("ERROR: trying to convert data to JSON")
                print(error)
            }
        })
        task.resume()
    }
    
}
