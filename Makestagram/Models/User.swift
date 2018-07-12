//
//  User.swift
//  Makestagram
//
//  Created by Noah Woodward on 7/9/18.
//  Copyright © 2018 Noah Woodward. All rights reserved.
//

import Foundation
import FirebaseDatabase.FIRDataSnapshot

class User{
    let uid: String
    let username: String
    
    init(uid: String, username: String){
        self.uid = uid
        self.username = username
    }
    
    init?(snapshot: DataSnapshot){
        guard let dict = snapshot.value as? [String: Any],
        let username = dict["username"] as? String
        else { return nil }
       
        self.uid = snapshot.key
        self.username = username
    }
    
    
    // MARK: - Singleton
    
    // 1
    private static var _current: User?
    
    // 2
    static var current: User {
        // 3
        guard let currentUser = _current else {
            fatalError("Error: current user doesn't exist")
        }
        
        // 4
        return currentUser
    }
    
    // MARK: - Class Methods
    
    // 5
    static func setCurrent(_ user: User) {
        _current = user
    }
}
