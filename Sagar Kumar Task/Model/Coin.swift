//
//  Coin.swift
//  Sagar Kumar Task
//
//  Created by Sagar Kumar on 28/11/24.
//

import Foundation

struct Coin: Codable {
    
    let name: String?
    let symbol: String?
    let type: CoinType?
    let isActive: Bool?
    let isNew: Bool?
    
    var status: CoinStatus? {
        guard isActive == true else { return .inactive }
        return type == .coin ? .activeCoin : type == .token ? .activeToken : nil
    }
    
    enum CodingKeys: String, CodingKey {
        case name, symbol, type
        case isActive = "is_active"
        case isNew = "is_new"
    }
}

enum CoinType: String, Codable {
    case coin = "coin"
    case token = "token"
}

enum CoinStatus {
    case activeCoin, activeToken, inactive
    
    var imageName: String {
        switch self {
        case .activeCoin:
            return .coinActive
        case .activeToken:
            return .tokenActive
        case .inactive:
            return .inactive
        }
    }
}
