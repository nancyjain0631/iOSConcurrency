//
//  UsersListVM.swift
//  iOSConcurrency
//
//  Created by Nancy Jain on 24/06/24.
//

import Foundation

class UsersListVM: ObservableObject {
    @Published var users: [UserModel] = []
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var errorMessage: String?
    
    func fetchUsers() {
        let apiService = APIService(urlString:  "https://jsonplaceholder.typicode.com/users")
        isLoading.toggle()
            apiService.getJson { (result: Result<[UserModel], APIErrorEnum>) in
                defer {
                    DispatchQueue.main.async {
                        self.isLoading.toggle()
                    }
                }
                switch result {
                    case .success(let users):
                        DispatchQueue.main.async {
                            self.users = users
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

extension UsersListVM {
    convenience init(forPreview: Bool = false) {
        self.init()
        if forPreview {
            self.users = UserModel.mockUsers
        }
    }
}
