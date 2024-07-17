//
//  PostsListVM.swift
//  iOSConcurrency
//
//  Created by Nancy Jain on 24/06/24.
//

import Foundation

class PostsListVM: ObservableObject {
    @Published var posts: [PostModel] = []
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var errorMessage: String?
    
    var userId: Int?
    
    func fetchPosts() {
        if let userId = userId {
            let apiService = APIService(urlString:  "https://jsonplaceholder.typicode.com/\(userId)/posts")
            isLoading.toggle()
                apiService.getJson { (result: Result<[PostModel], APIErrorEnum>) in
                    defer {
                        DispatchQueue.main.async {
                            self.isLoading.toggle()
                        }
                    }
                    switch result {
                        case .success(let posts):
                            DispatchQueue.main.async {
                                self.posts = posts
                            }
                        case .failure(let error):
                            DispatchQueue.main.async {
                                self.showAlert = true
                                self.errorMessage = error.localizedDescription + "\nPlease contact the developer"
                            }
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
