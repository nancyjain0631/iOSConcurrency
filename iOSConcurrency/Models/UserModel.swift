//
//  UserModel.swift
//  iOSConcurrency
//
//  Created by Nancy Jain on 22/06/24.
//

import Foundation

// https://jsonplaceholder.typicode.com/users

struct UserModel: Codable, Identifiable {
    let id: Int
    let name: String?
    let username: String?
    let email: String?
    
}

