//
//  APIService.swift
//  iOSConcurrency
//
//  Created by Nancy Jain on 22/06/24.
//

import Foundation

// we're creating 5 cases for our use case in func getUsers()
enum APIErrorEnum: Error, LocalizedError{
    case invalidURL
    case invalidResponseStatus
    case dataTaskError(String)
    case corruptData
    case decodingError(String)
    
    var errorDescription: String? {
        switch self {
            case .invalidURL:
                return NSLocalizedString("The endpoint URL is invalid", comment: "")
            case .invalidResponseStatus:
                return NSLocalizedString("The API failed to isssue a valid response.", comment: "")
            case .dataTaskError(let string):
                return string
            case .corruptData:
                return NSLocalizedString("The data provided appears to be corrupt", comment: "")
            case .decodingError(let string):
                return string
        }
    }
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
                completion(.failure(.dataTaskError(error!.localizedDescription)))
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
                completion(.failure(.decodingError(error.localizedDescription)))
            }
            
        }.resume()
    }
}


