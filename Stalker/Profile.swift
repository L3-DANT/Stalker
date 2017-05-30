 //
 //  Profile.swift
 //  Stalker
 //
 //  Created by Agnès Herrera on 28/05/2017.
 //  Copyright © 2017 m2sar. All rights reserved.
 //
 
 import Foundation
 
 final class Profile: UserDefaults {
    
    // MARK: Initialization
    
    private convenience init() {
        self.init()
        Profile.standard.setNilValueForKey("token")
        Profile.standard.setNilValueForKey("email")
        Profile.standard.setNilValueForKey("isConnected")
        Profile.standard.setNilValueForKey("isSharingPosition")
    }
    
    // MARK: Methods
    
    static func getToken() -> String? {
        return Profile.standard.value(forKey: "token") as? String
    }
    
    static func getEmail() -> String? {
        return Profile.standard.value(forKey: "email") as? String
    }
    
    static func getIsConnected() -> Bool? {
        return Profile.standard.value(forKey: "isConnected") as? Bool
    }
    
    static func getIsSharingPosition() -> Bool? {
        return Profile.standard.value(forKey: "isSharingPosition") as? Bool
    }
    
    static func setToken(_ token: String?) {
        Profile.standard.set(token, forKey: "token")
    }
    
    static func setEmail(_ email: String?) {
        Profile.standard.set(email, forKey: "email")
    }
    
    static func setIsConnected(_ isConnected: Bool?) {
        Profile.standard.set(isConnected, forKey: "isConnected")
    }
    
    static func setIsSharingPosition(_ isSharingPosition: Bool?) {
        Profile.standard.set(isSharingPosition, forKey: "isSharingPosition")
    }
    
    
 }
