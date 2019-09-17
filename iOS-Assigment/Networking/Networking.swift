//
//  Networking.swift
//  iOS-Assigment
//
//  Created by Aminjoni Abdullozoda on 9/16/19.
//  Copyright © 2019 Aminjoni Abdullozoda. All rights reserved.
//

import Foundation

public class Networking {
    let shared = Networking()
    
    static let baseURL = "https://frogogo-test.herokuapp.com/"
    
    enum ResoursePath : String {
        case users = "users.json"
        case user = "users"
        
        var path : String {
            return baseURL + rawValue
        }
    }
}
