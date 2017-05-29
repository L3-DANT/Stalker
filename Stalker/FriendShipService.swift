//
//  FriendShipService.swift
//  Stalker
//
//  Created by m2sar on 29/05/17.
//  Copyright © 2017 m2sar. All rights reserved.
//

import Foundation

final class FriendShipService {
    
    // MARK: Initializers
    
    private init() {}
    
    // MARK: Builders
    
    typealias FriendShipBuilder = (FriendShip) throws -> FriendShip
    typealias FriendShipsBuilder = () throws -> [FriendShip]
    
    // MARK: Methods
    
    static func create(friendship: FriendShip, completion: @escaping (FriendShipBuilder) -> Void) {
        
        // TODO: remove friendship
        
        let user = User(token: "0")
        
        let json = try? JSONSerialization.data(withJSONObject: friendship.toDictionary())
        
        let session = URLSession.shared
        
        var request = URLRequest(url: URL(string: "http://35.187.15.102:8080/api/friendship")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // TODO: set token
        
        request.addValue(user.token!, forHTTPHeaderField: "Token")
        
        request.httpBody = json
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            completion({ FriendShipBuilder in
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
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String : Any] {
                        return FriendShip(json: json)
                    }
                }
                catch let error {
                    throw SerializationError.JSONObject(error)
                }
                return FriendShip()
            })
        })
        task.resume()
    }
    
    static func get(friendship: FriendShip, completion: @escaping (FriendShipBuilder) -> Void) {
        
        // TODO: remove user
        
        let user = User(token: "0")
        
        let session = URLSession.shared
        
        var request = URLRequest(url: URL(string: "http://35.187.15.102:8080/api/friendship/\(friendship.id!))")!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        // TODO: set token
        
        request.addValue(user.token!, forHTTPHeaderField: "Token")
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            completion({ FriendShipBuilder in
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
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String : Any] {
                        return FriendShip(json: json)
                    }
                }
                catch let error {
                    throw SerializationError.JSONObject(error)
                }
                return FriendShip()
            })
        })
        task.resume()
    }
    
    static func getAll(completion: @escaping (FriendShipsBuilder) -> Void) {
        
        // TODO: remove user
        
        let user = User(token: "0")
        
        // set up session
        //        let config = URLSessionConfiguration.default
        //        let session = URLSession(configuration: config)
        let session = URLSession.shared
        
        // TODO: update url
        
        var request = URLRequest(url: URL(string: "http://35.187.15.102:8080/api/friendship")!)
        //        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringCacheData
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        // TODO: set token
        
        request.addValue(user.token!, forHTTPHeaderField: "Token")
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            completion({ FriendShipsBuilder in
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
                var friendships = [FriendShip]()
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [[String : Any]] {
                        for friendship in json {
                            friendships.append(FriendShip(json: friendship))
                        }
                    }
                }
                catch let error {
                    throw SerializationError.JSONObject(error)
                }
                return friendships
            })
        })
        task.resume()
    }
    
    static func update(meetpoint: FriendShip, completion: @escaping (FriendShipBuilder) -> Void) {
        
        // TODO: remove user
        
        let user = User(token: "0")
        
        let json = try? JSONSerialization.data(withJSONObject: meetpoint.toDictionary())
        
        let session = URLSession.shared
        
        var request = URLRequest(url: URL(string: "http://35.187.15.102:8080/api/meetpoint/")!)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // TODO: set token
        
        request.addValue(user.token!, forHTTPHeaderField: "Token")
        
        request.httpBody = json
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            completion({ FriendShipBuilder in
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
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String : Any] {
                        return FriendShip(json: json)
                    }
                }
                catch let error {
                    throw SerializationError.JSONObject(error)
                }
                return FriendShip()
            })
        })
        task.resume()
    }
    
    static func delete(friendship: FriendShip, completion: @escaping (FriendShipBuilder) -> Void) {
        
        // TODO: remove user
        
        let user = User(token: "0")
        
        let session = URLSession.shared
        
        var request = URLRequest(url: URL(string: "http://35.187.15.102:8080/api/meetpoint/\(friendship.id!))")!)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        // TODO: set token
        
        request.addValue(user.token!, forHTTPHeaderField: "Token")
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            completion({ FriendShipBuilder in
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
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String : Any] {
                        return FriendShip(json: json)
                    }
                }
                catch let error {
                    throw SerializationError.JSONObject(error)
                }
                return FriendShip()
            })
        })
        task.resume()
    }
    
}
