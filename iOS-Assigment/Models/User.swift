//
//  User.swift
//  iOS-Assigment
//
//  Created by Aminjoni Abdullozoda on 9/16/19.
//  Copyright © 2019 Aminjoni Abdullozoda. All rights reserved.
//

//
import Foundation

struct UserElement: Codable {
    let id: Int
    let firstName, lastName, email: String
    let avatarURL: String?
    let createdAt, updatedAt: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case avatarURL = "avatar_url"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case url
    }
}

typealias Users = [UserElement]

