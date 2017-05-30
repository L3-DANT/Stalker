//
//  FriendshipService.swift
//  Stalker
//
//  Created by kvin on 29/05/2017.
//  Copyright © 2017 m2sar. All rights reserved.
//
import Foundation

final class FriendshipService {
    
    // MARK: Initializers
    
    private init() { }
    
    // MARK: Methods
    
    static func create(friendship: Friendship, completion: @escaping (FriendshipBuilder) -> Void) {
        
        let json = try? JSONSerialization.data(withJSONObject: friendship.toDictionary())
        
        let session = URLSession.shared
        
        var request = URLRequest(url: URL(string: "\(Server.address)/\(Collection.friend)")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(Profile.getToken()!, forHTTPHeaderField: "Token")
        
        request.httpBody = json
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            completion({ FriendshipBuilder in
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
                        return Friendship(json: json)
                    }
                }
                catch let error {
                    throw SerializationError.jsonObject(error)
                }
                return Friendship()
            })
        })
        task.resume()
    }
    
    static func get(friendship: Friendship, completion: @escaping (FriendshipBuilder) -> Void) {
        
        let session = URLSession.shared
        
        var request = URLRequest(url: URL(string: "\(Server.address)/\(Collection.friend)/\(friendship.id!))")!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(Profile.getToken()!, forHTTPHeaderField: "Token")
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            completion({ FriendshipBuilder in
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
                        return Friendship(json: json)
                    }
                }
                catch let error {
                    throw SerializationError.jsonObject(error)
                }
                return Friendship()
            })
        })
        task.resume()
    }
    
    static func getAll(completion: @escaping (FriendshipsBuilder) -> Void) {
        
        let session = URLSession.shared
        
        var request = URLRequest(url: URL(string: "\(Server.address)/\(Collection.friend)")!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(Profile.getToken()!, forHTTPHeaderField: "Token")
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            completion({ FriendshipsBuilder in
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
                var friendships = [Friendship]()
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [[String : Any]] {
                        for friendship in json {
                            friendships.append(Friendship(json: friendship))
                        }
                    }
                }
                catch let error {
                    throw SerializationError.jsonObject(error)
                }
                return friendships
            })
        })
        task.resume()
    }
    
    static func update(friendship: Friendship, completion: @escaping (EmptyBuilder) -> Void) {
        
        let json = try? JSONSerialization.data(withJSONObject: friendship.toDictionary())
        
        let session = URLSession.shared
        
        var request = URLRequest(url: URL(string: "\(Server.address)/\(Collection.friend)")!)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(Profile.getToken()!, forHTTPHeaderField: "Token")
        
        request.httpBody = json
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            completion({ FriendshipBuilder in
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
    
    static func delete(friendship: Friendship, completion: @escaping (FriendshipBuilder) -> Void) {
        
        let session = URLSession.shared
        
        var request = URLRequest(url: URL(string: "\(Server.address)/\(Collection.friend)/\(friendship.id!))")!)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(Profile.getToken()!, forHTTPHeaderField: "Token")
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            completion({ FriendshipBuilder in
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
                        return Friendship(json: json)
                    }
                }
                catch let error {
                    throw SerializationError.jsonObject(error)
                }
                return Friendship()
            })
        })
        task.resume()
    }
    
}
