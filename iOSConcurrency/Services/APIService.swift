//
//  APIService.swift
//  iOSConcurrency
//
//  Created by Nancy Jain on 22/06/24.
//

import Foundation

// we're creating 5 cases for our use case in func getUsers()
enum APIErrorEnum: Error {
    case invalidURL
    case invalidResponseStatus
    case dataTaskError
    case corruptData
    case decodingError
}

struct APIService {
    let urlString: String // can be users or posts
    
    // reason we're using ocmpeltion handler as we don't know how much it'll take to fetch the data
    // since the functions are synchronous in SwiftUI, we want our completion handler to outlive even after the function has expired, for that we're using @escaping
    func getJson<T: Decodable>(dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys, completion: @escaping (Result<T, APIErrorEnum>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                completion(.failure(.invalidResponseStatus))
                return
                  }
            
            guard error == nil else {
                completion(.failure(.dataTaskError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.corruptData))
                return
                
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = dateDecodingStrategy
            decoder.keyDecodingStrategy = keyDecodingStrategy
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingError))
                print("Error")
            }
            
        }.resume()
    }
}


