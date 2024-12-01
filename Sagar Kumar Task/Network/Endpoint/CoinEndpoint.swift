//
//  CoinEndPoint.swift
//  Sagar Kumar Task
//
//  Created by Sagar Kumar on 28/11/24.
//

import Foundation

enum CoinEndpoint: NetworkEndpoint {
    
    case fetchCoins
    
    var baseURL: URL? {
        return URL(string: AppConfiguration.baseURL)
    }
    
    var path: String {
        switch self {
        case .fetchCoins:
            return ""
        }
    }
    
    var url: URL? {
        guard let url = baseURL?.appendingPathComponent(path) else { return nil }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = queryParameters
        return components?.url
    }
    
    var method: String {
        switch self {
        case .fetchCoins:
            return "GET"
        }
    }
    
    var queryParameters: [URLQueryItem]? {
        switch self {
        case .fetchCoins:
            return nil
        }
    }
}
