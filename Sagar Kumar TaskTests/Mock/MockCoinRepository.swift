//
//  CoinListTest.swift
//  Sagar Kumar TaskTests
//
//  Created by Sagar Kumar on 30/11/24.
//

class MockCoinRepository: CoinRepositoryFetcher {
    var result: Result<[Coin], NetworkError>?

    func fetchCoins(completion: @escaping (Result<[Coin], NetworkError>) -> Void) {
        if let result = result {
            completion(result)
        }
    }
}
