 //
 //  Session.swift
 //  Stalker
 //
 //  Created by Agnès Herrera on 28/05/2017.
 //  Copyright © 2017 m2sar. All rights reserved.
 //
 
 import Foundation
 
 final class Session: UserDefaults {
    
    // MARK: Initializers
    
    private convenience init() {
        self.init()
        Session.standard.setNilValueForKey("token")
        Session.standard.setNilValueForKey("name")
        Session.standard.setNilValueForKey("email")
        Session.standard.setNilValueForKey("isConnected")
        Session.standard.setNilValueForKey("isSharingPosition")
    }
    
    // MARK: Methods
    
    static func getToken() -> String? {
        return Session.standard.value(forKey: "token") as? String
    }
    static func getName() -> String? {
        return Session.standard.value(forKey: "name") as? String
    }
    static func getEmail() -> String? {
        return Session.standard.value(forKey: "email") as? String
    }
    static func getIsConnected() -> Bool? {
        return Session.standard.value(forKey: "isConnected") as? Bool
    }
    static func getIsSharingPosition() -> Bool? {
        return Session.standard.value(forKey: "isSharingPosition") as? Bool
    }
    static func setToken(_ token: String?) {
        Session.standard.set(token, forKey: "token")
    }
    static func setName(_ name: String?) {
        Session.standard.set(name, forKey: "name")
    }
    static func setEmail(_ email: String?) {
        Session.standard.set(email, forKey: "email")
    }
    static func setIsConnected(_ isConnected: Bool?) {
        Session.standard.set(isConnected, forKey: "isConnected")
    }
    static func setIsSharingPosition(_ isSharingPosition: Bool?) {
        Session.standard.set(isSharingPosition, forKey: "isSharingPosition")
    }
    
 }
