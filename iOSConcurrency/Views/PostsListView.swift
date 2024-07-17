//
//  PostsListView.swift
//  iOSConcurrency
//
//  Created by Nancy Jain on 24/06/24.
//

import SwiftUI

struct PostsListView: View {
    @StateObject var vm = PostsListVM(forPreview: true)
    var userId: Int?
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                if let title = post.title {
                    VStack(alignment: .leading) {
                        Text(title)
                            .font(.headline)
                        Text(post.body ?? "")
                            .font(.callout)
                            .foregroundColor(.secondary)
                    }
                }
                
            }
        }
        .overlay(content: {
            if vm.isLoading {
                ProgressView()
            }
        })
        .alert("Application Error", isPresented: $vm.showAlert, actions: {
            Button("OK") {}
        }, message: {
            if let errorMessage = vm.errorMessage {
                Text(errorMessage)
            }
        })
        .navigationTitle("Posts")
        .navigationBarTitleDisplayMode(.inline)
        .listStyle(.plain)
        .onAppear {
            vm.userId = userId
            vm.fetchPosts()
        }
    }
}

struct PostsListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PostsListView(userId: 1)
        }
        
    }
}
