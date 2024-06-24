//
//  UsersListVM.swift
//  iOSConcurrency
//
//  Created by Nancy Jain on 24/06/24.
//

import Foundation

class UsersListVM: ObservableObject {
    @Published var users: [UserModel] = []
    
    func fetchUsers() {
        let apiService = APIService(urlString:  "https://jsonplaceholder.typicode.com/users")
        apiService.getJson { (result: Result<[UserModel], APIErrorEnum>) in
            switch result {
                case .success(let users):
                    DispatchQueue.main.async {
                        self.users = users
                    }
                case .failure(let error):
                    print(error)
            }
        }
        
    }
}

extension UsersListVM {
    convenience init(forPreview: Bool = false) {
        self.init()
        if forPreview {
            self.users = UserModel.mockUsers
        }
    }
}
