//
//  PostsListVM.swift
//  iOSConcurrency
//
//  Created by Nancy Jain on 24/06/24.
//

import Foundation

class PostsListVM: ObservableObject {
    @Published var posts: [PostModel] = []
    var userId: Int?
    
    func fetchPosts() {
        if let userId = userId {
            let apiService = APIService(urlString:  "https://jsonplaceholder.typicode.com/\(userId)/posts")
            apiService.getJson { (result: Result<[PostModel], APIErrorEnum>) in
                switch result {
                    case .success(let posts):
                        DispatchQueue.main.async {
                            self.posts = posts
                        }
                    case .failure(let error):
                        print(error)
                }
            }
        }
    }
}

extension PostsListVM {
    convenience init(forPreview: Bool = false) {
        self.init()
        if forPreview {
            self.posts = PostModel.mockSingleUserPostsArray
        }
    }
}
