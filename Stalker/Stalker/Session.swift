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
        self.email = nil
        self.password = nil
    }
    
    init(email: String, password: String){
        self.email=email
        self.password=password
    }
    
    func connexion() -> Bool {
        if (self.email != nil && self.password != nil){
            let feedURL = "http://"
            let request = URLRequest(url: URL(string: feedURL)!)//definir type de methode get ou post
            //request.httpBody
            
            // Dictionary ---[JSONSeriqlisation]--> Data
            
            let sessionHTTP = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                DispatchQueue.main.async {
                    if let jsonData = data,
                        let feed = (try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)) as? NSDictionary {
                            feed.setValue(self.email, forKeyPath: "email")
                            feed.setValue(self.password, forKeyPath: "password")
                        //envoyer requete
                        //tester la reponse http 200 ou 401
                        let httpResponse = response as? HTTPURLResponse
                        if (httpResponse != nil) {
                            if httpResponse?.statusCode == 200 {
                                self.token = httpResponse?.allHeaderFields["token"] as! String?
                            }
                            else {
                                exit(1)
                            }
                        }
                    }
                }
            })
        sessionHTTP.resume()
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
