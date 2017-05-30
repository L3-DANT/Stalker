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
    
    static func create(meetpoint: MeetPoint, completion: @escaping (MeetPointBuilder) -> Void) {
        
        // TODO: remove user
        
        let user = User(token: "0")
        
        let json = try? JSONSerialization.data(withJSONObject: meetpoint.toDictionary())
        
        let session = URLSession.shared
        
        var request = URLRequest(url: URL(string: "\(Server.address)/\(Collection.meetpoint)")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // TODO: set token
        
        request.addValue(user.token!, forHTTPHeaderField: "Token")
        
        request.httpBody = json
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            completion({ MeetPointBuilder in
                if let error = error {
                    throw HttpRequestError.error(error)
                }
                if let httpResponse = response as? HTTPURLResponse {
                    guard httpResponse.statusCode == 200 else {
                        throw HttpRequestError.statusCode(httpResponse.statusCode)
                    }
                }
                guard let data = data else {
                    throw HttpRequestError.emptyData
                }
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String : Any] {
                        return MeetPoint(json: json)
                    }
                }
                catch let error {
                    throw SerializationError.jsonObject(error)
                }
                return MeetPoint()
            })
        })
        task.resume()
    }
    
    static func get(meetpoint: MeetPoint, completion: @escaping (MeetPointBuilder) -> Void) {
        
        // TODO: remove user
        
        let user = User(token: "0")
        
        let session = URLSession.shared
        
        var request = URLRequest(url: URL(string: "\(Server.address)/\(Collection.meetpoint)/\(meetpoint.id!))")!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        // TODO: set token
        
        request.addValue(user.token!, forHTTPHeaderField: "Token")
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            completion({ MeetPointBuilder in
                if let error = error {
                    throw HttpRequestError.error(error)
                }
                if let httpResponse = response as? HTTPURLResponse {
                    guard httpResponse.statusCode == 200 else {
                        throw HttpRequestError.statusCode(httpResponse.statusCode)
                    }
                }
                guard let data = data else {
                    throw HttpRequestError.emptyData
                }
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String : Any] {
                        return MeetPoint(json: json)
                    }
                }
                catch let error {
                    throw SerializationError.jsonObject(error)
                }
                return MeetPoint()
            })
        })
        task.resume()
    }
    
    static func getAll(completion: @escaping (MeetPointsBuilder) -> Void) {
        
        // TODO: remove user
        
        let user = User(token: "0")
        
        // set up session
        //        let config = URLSessionConfiguration.default
        //        let session = URLSession(configuration: config)
        let session = URLSession.shared
        
        // TODO: update url
        
        var request = URLRequest(url: URL(string: "\(Server.address)/\(Collection.meetpoint)")!)
        //        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringCacheData
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        // TODO: set token
        
        request.addValue(user.token!, forHTTPHeaderField: "Token")
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            completion({ MeetPointsBuilder in
                if let error = error {
                    throw HttpRequestError.error(error)
                }
                if let httpResponse = response as? HTTPURLResponse {
                    guard httpResponse.statusCode == 200 else {
                        throw HttpRequestError.statusCode(httpResponse.statusCode)
                    }
                }
                guard let data = data else {
                    throw HttpRequestError.emptyData
                }
                var meetpoints = [MeetPoint]()
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [[String : Any]] {
                        for meetpoint in json {
                            meetpoints.append(MeetPoint(json: meetpoint))
                        }
                    }
                }
                catch let error {
                    throw SerializationError.jsonObject(error)
                }
                return meetpoints
            })
        })
        task.resume()
    }
    
    static func update(meetpoint: MeetPoint, completion: @escaping (MeetPointBuilder) -> Void) {
        
        // TODO: remove user
        
        let user = User(token: "0")
        
        let json = try? JSONSerialization.data(withJSONObject: meetpoint.toDictionary())
        
        let session = URLSession.shared
        
        var request = URLRequest(url: URL(string: "\(Server.address)/\(Collection.meetpoint)")!)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // TODO: set token
        
        request.addValue(user.token!, forHTTPHeaderField: "Token")
        
        request.httpBody = json
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            completion({ MeetPointBuilder in
                if let error = error {
                    throw HttpRequestError.error(error)
                }
                if let httpResponse = response as? HTTPURLResponse {
                    guard httpResponse.statusCode == 200 else {
                        throw HttpRequestError.statusCode(httpResponse.statusCode)
                    }
                }
                guard let data = data else {
                    throw HttpRequestError.emptyData
                }
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String : Any] {
                        return MeetPoint(json: json)
                    }
                }
                catch let error {
                    throw SerializationError.jsonObject(error)
                }
                return MeetPoint()
            })
        })
        task.resume()
    }
    
    static func delete(meetpoint: MeetPoint, completion: @escaping (EmptyBuilder) -> Void) {
        
        // TODO: remove user
        
        let user = User(token: "0")
        
        let session = URLSession.shared
        
        var request = URLRequest(url: URL(string: "\(Server.address)/\(Collection.meetpoint)/\(meetpoint.id!))")!)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        // TODO: set token
        
        request.addValue(user.token!, forHTTPHeaderField: "Token")
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            completion({ MeetPointBuilder in
                if let error = error {
                    throw HttpRequestError.error(error)
                }
                if let httpResponse = response as? HTTPURLResponse {
                    guard httpResponse.statusCode == 200 else {
                        throw HttpRequestError.statusCode(httpResponse.statusCode)
                    }
                }
            })
        })
        task.resume()
    }
    
}
