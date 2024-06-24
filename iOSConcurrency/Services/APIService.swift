//
//  APIService.swift
//  iOSConcurrency
//
//  Created by Nancy Jain on 22/06/24.
//

import Foundation

struct APIService {
    let urlString: String // can be users or posts
    
    // reason we're using ocmpeltion handler as we don't know how much it'll take to fetch the data
    // since the functions are synchronous in SwiftUI, we want our completion handler to outlive even after the function has expired, for that we're using @escaping
    func getUsers(completion: @escaping ([UserModel]) -> Void) {
        guard let url = URL(string: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                      return
                  }
            guard error == nil else {
                return
            }
            guard let data = data else { return }
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode([UserModel].self, from: data)
                completion(decodedData)
            } catch {
                print("Error")
            }
        }.resume()
    }
}
