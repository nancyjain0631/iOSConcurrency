//
//  UsersListView.swift
//  iOSConcurrency
//
//  Created by Nancy Jain on 22/06/24.
//

import SwiftUI

struct UsersListView: View {
    #warning("remove the forPreview argument or set it to false before uploading")
    @StateObject var vm = UsersListVM(forPreview: false)
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.users) { user in
                    NavigationLink {
                        PostsListView(userId: user.id)
                    } label: {
                        if let userName = user.name {
                            VStack(alignment: .leading) {
                                Text(userName)
                                    .font(.title)
                                Text(user.email ?? "")
                            }
                        }
                    }

                    
                    
                }
            }
            .navigationTitle("Users")
            .listStyle(.plain)
            .onAppear {
                vm.fetchUsers()
            }
        }
    }
}

struct UsersListView_Previews: PreviewProvider {
    static var previews: some View {
        UsersListView()
    }
}
