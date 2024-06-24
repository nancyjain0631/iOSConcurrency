//
//  MockData.swift
//  iOSConcurrency
//
//  Created by Nancy Jain on 24/06/24.
//

import Foundation

extension UserModel {
    
    static var mockUsers: [UserModel] {
        Bundle.main.decode([UserModel].self, from: "users.json")
    }
    static var mockSingleUser: UserModel {
        Self.mockUsers[0]
    }
}
extension PostModel {
    
    static var mockPosts: [PostModel] {
        Bundle.main.decode([PostModel].self, from: "posts.json")
    }
    static var mockSinglePost: PostModel {
        Self.mockPosts[0]
    }
    static var mockSingleUserPostsArray: [PostModel] {
        Self.mockPosts.filter { $0.userId == 1}
    }
}
