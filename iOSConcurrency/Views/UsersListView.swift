//
//  UsersListView.swift
//  iOSConcurrency
//
//  Created by Nancy Jain on 22/06/24.
//

import SwiftUI

struct UsersListView: View {
    @StateObject var vm = UsersListVM()
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.users) { user in
                    if let userName = user.name {
                        VStack(alignment: .leading) {
                            Text(userName)
                                .font(.title)
                            Text(user.email ?? "")
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
