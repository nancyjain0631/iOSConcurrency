//
//  PostModel.swift
//  iOSConcurrency
//
//  Created by Nancy Jain on 22/06/24.
//

import Foundation

struct PostModel: Codable, Identifiable {
    let userId: Int
    let id: Int
    let title: String?
    let body: String?
}
