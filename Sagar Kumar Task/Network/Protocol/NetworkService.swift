//
//  NetworkService.swift
//  Sagar Kumar Task
//
//  Created by Sagar Kumar on 28/11/24.
//

import Foundation

protocol NetworkService {
    func fetch<T: Decodable>(endpoint: NetworkEndpoint, completion: @escaping (Result<T, NetworkError>) -> Void)
}
