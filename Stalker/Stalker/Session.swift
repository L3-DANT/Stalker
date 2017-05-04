//
//  Session.swift
//  Stalker
//
//  Created by m2sar on 03/05/17.
//  Copyright © 2017 m2sar. All rights reserved.
//

import Foundation

class Session {
    private let email: String?
    private let password: String?
    private var token: String?
    
    init() {
        self.email = "bob@gsdmail.com"
        self.password = "1234"
    }
    
    init(email: String, password: String){
        self.email=email
        self.password=password
    }
    
    func connexion() -> Bool {
        if (self.email != nil && self.password != nil){

            let json: [String: Any] = ["email": self.email,
                                       "password": self.password]
            
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            
            // create post request
            let url = URL(string: "http://35.187.122.195:8080/api/user/")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            // insert json data to the request
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                if let responseJSON = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                        self.token = responseJSON?.value(forKeyPath: "token") as? String
                }
            }
            
            task.resume()
        }
        if (self.token != nil) { return true }
        else { return false }
    }
    
    func inscription() -> Bool {
        return true
    }
    
    func getToken() -> String {
        return self.token!
    }
    
}
