//
//  APIClient.swift
//  Sagar Kumar Task
//
//  Created by Sagar on 28/11/24.
//

import Foundation

struct APIClient: NetworkService {
    
    func fetch<T: Decodable>(endpoint: NetworkEndpoint, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = endpoint.url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error as? NSError {
                if error.domain == NSURLErrorDomain && error.code == -1009 {
                    completion(.failure(NetworkError.noInternet))
                } else {
                    completion(.failure(NetworkError.unknown(error)))
                }
                return
            } 
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedObject))
            } catch {
                completion(.failure(NetworkError.decodingError(error)))
            }
        }.resume()
    }
}

