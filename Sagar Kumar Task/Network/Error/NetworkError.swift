//
//  NetworkError.swift
//  Sagar Kumar Task
//
//  Created by Sagar Kumar on 28/11/24.
//

import Foundation

enum NetworkError: Error {
    
    case invalidURL
    case noData
    case decodingError(Error)
    case unknown(Error)
    case noInternet
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
        case .noData:
            return "No data was returned from the server."
        case .decodingError(let error):
            return "Failed to decode response: \(error.localizedDescription)."
        case .unknown(let error):
            return "An unknown error occurred: \(error.localizedDescription)."
        case .noInternet:
            return "It seems your device is offline. Please check your connection and try again."
        }
    }
}
