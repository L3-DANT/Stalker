//
//  Service.swift
//  Stalker
//
//  Created by m2sar on 26/05/17.
//  Copyright © 2017 m2sar. All rights reserved.
//

import Foundation

class UserService {
    
    static func authenticate(user: User, completionHandler: @escaping (_ result: User) -> ()) throws {
        
//        if let jsonData = try? JSONSerialization.data(withJSONObject: user.toDictionary()) {
//            let url = URL(string: "http://35.187.15.102:8080/api/user/authenticate")!
//            var request = URLRequest(url: url)
//            request.httpMethod = "POST"
//            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.httpBody = jsonData
//            
//            let session = URLSession.shared
//            let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
//                guard error == nil else {
//                    print(error?.localizedDescription)
//                    return
//                }
//                guard let data = data else {
//                    print(error?.localizedDescription)
//                    return
//                }
//                let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
//                if let parseJSON = json {
//                    completionHandler(User(json: parseJSON!))
//                }
//            })
//            task.resume()
//        }
        
//        print("result: \(result)")
    }
    
}
