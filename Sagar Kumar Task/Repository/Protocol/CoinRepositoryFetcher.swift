//
//  CoinRepositoryFetcher.swift
//  Sagar Kumar Task
//
//  Created by Sagar Kumar on 30/11/24.
//

import Foundation

protocol CoinRepositoryFetcher {
    func fetchCoins(completion: @escaping (Result<[Coin], NetworkError>) -> Void)
}
