//
//  UserService.swift
//  Stalker
//
//  Created by kvin on 30/05/2017.
//  Copyright © 2017 m2sar. All rights reserved.
//
import Foundation

final class UserService {
    
    // MARK: Initializers
    
    private init() {}
    
    // MARK: Builders
    
    typealias UserBuilder = (User) throws -> User
    typealias UsersBuilder = () throws -> [User]
    
    // MARK: Methods
    
    static func create(user: User, completion: @escaping (UserBuilder) -> Void) {
        
        // TODO: set token
        
        let token = User(token: "0").token!
        
        let json = try? JSONSerialization.data(withJSONObject: user.toDictionary())
        
        let session = URLSession.shared
        
        var request = URLRequest(url: URL(string: "\(Server.address)/\(Collection.user)")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(token, forHTTPHeaderField: "Token")
        
        request.httpBody = json
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            completion({ UserBuilder in
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
                        return User(json: json)
                    }
                }
                catch let error {
                    throw SerializationError.jsonObject(error)
                }
                return User()
            })
        })
        task.resume()
    }
    
    static func get(user: User, completion: @escaping (UserBuilder) -> Void) {
        
        // TODO: set token
        
        let token = User(token: "0").token!
        
        let session = URLSession.shared
        
        var request = URLRequest(url: URL(string: "\(Server.address)/\(Collection.user)/\(user.id!))")!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(token, forHTTPHeaderField: "Token")
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            completion({ UserBuilder in
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
                        return User(json: json)
                    }
                }
                catch let error {
                    throw SerializationError.jsonObject(error)
                }
                return User()
            })
        })
        task.resume()
    }
    
    static func getFriends(isAccepted: Bool? = nil, completion: @escaping (UsersBuilder) -> Void) {
        
        // TODO: set token
        
        let token = User(token: "0").token!
        let session = URLSession.shared
    
        var url = "\(Server.address)/\(Collection.friend)"
        
        if let isAccepted = isAccepted {
            url += "/?isAccepted=\(isAccepted)"
        }
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(token, forHTTPHeaderField: "Token")
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            completion({ UsersBuilder in
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
                var users = [User]()
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [[String : Any]] {
                        for user in json {
                            users.append(User(json: user))
                        }
                    }
                }
                catch let error {
                    throw SerializationError.jsonObject(error)
                }
                return users
            })
        })
        task.resume()
    }
    
    static func update(user: User, completion: @escaping (UserBuilder) -> Void) {
        
        // TODO: set token
        
        let token = User(token: "0").token!
        
        let json = try? JSONSerialization.data(withJSONObject: user.toDictionary())
        
        let session = URLSession.shared
        
        var request = URLRequest(url: URL(string: "\(Server.address)/\(Collection.user)")!)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(token, forHTTPHeaderField: "Token")
        
        request.httpBody = json
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            completion({ UserBuilder in
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
                        return User(json: json)
                    }
                }
                catch let error {
                    throw SerializationError.jsonObject(error)
                }
                return User()
            })
        })
        task.resume()
    }
    
    static func delete(user: User, completion: @escaping (UserBuilder) -> Void) {
        
        // TODO: set token
        
        let token = User(token: "0").token!
        
        let session = URLSession.shared
        
        var request = URLRequest(url: URL(string: "\(Server.address)/\(Collection.user)/\(user.id!))")!)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(token, forHTTPHeaderField: "Token")
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            completion({ UserBuilder in
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
                        return User(json: json)
                    }
                }
                catch let error {
                    throw SerializationError.jsonObject(error)
                }
                return User()
            })
        })
        task.resume()
    }
    
}
