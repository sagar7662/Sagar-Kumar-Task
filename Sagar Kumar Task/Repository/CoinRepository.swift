//
//  CoinRepository.swift
//  Sagar Kumar Task
//
//  Created by Sagar on 28/11/24.
//

class CoinRepository: CoinRepositoryFetcher {
    
    private let apiService: NetworkService
    private let coreDataService: CoreDataService

    init(apiService: NetworkService, coreDataService: CoreDataService = CoreDataService()) {
            self.apiService = apiService
            self.coreDataService = coreDataService
        }

    func fetchCoins(completion: @escaping (Result<[Coin], NetworkError>) -> Void) {
        let cachedCoins = self.coreDataService.fetchCoins()
        if !cachedCoins.isEmpty {
            completion(.success(cachedCoins))
        }
        apiService.fetch(endpoint: CoinEndpoint.fetchCoins, completion: { [weak self] (result: Result<[Coin], NetworkError>) in
            guard let self = self else { return }
            switch result {
            case .success(let coins):
                self.coreDataService.saveCoins(coins: coins)
                completion(.success(coins))
            case .failure(let error):
                if cachedCoins.isEmpty {
                    completion(.failure(error))
                }
            }
        })
    }
}
