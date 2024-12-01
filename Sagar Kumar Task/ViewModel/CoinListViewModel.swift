//
//  CoinListViewModel.swift
//  Sagar Kumar Task
//
//  Created by Sagar Kumar on 28/11/24.
//

import Foundation
import Combine

class CoinListViewModel: ObservableObject {
    
    @Published var filteredCoins: [Coin] = []
    @Published var errorMessage: String?
    private let repository: CoinRepositoryFetcher
    private var coins: [Coin] = []
    lazy var filters: [CoinFilter] = {
        return [CoinFilter(title: .activeCoins, type: .coin, isActive: true, isNew: nil, isSelected: false),
                CoinFilter(title: .inactiveCoins, type: .coin, isActive: false, isNew: nil, isSelected: false),
                CoinFilter(title: .onlyTokens, type: .token, isActive: nil, isNew: nil, isSelected: false),
                CoinFilter(title: .onlyCoins, type: .coin, isActive: nil, isNew: nil, isSelected: false),
                CoinFilter(title: .newCoins, type: .coin, isActive: nil, isNew: true, isSelected: false)]
    }()
    
    init(repository: CoinRepositoryFetcher) {
        self.repository = repository
    }
    
    func fetchCoins() {
        repository.fetchCoins { [weak self] (result: Result<[Coin], NetworkError>) in
            guard let self = self else { return }
            switch result {
            case .success(let coins):
                self.coins = coins
                self.filteredCoins = coins
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func filterCoins(with search: String = "") {
        let selectedFilters = self.filters.filter { $0.isSelected }
        var filteredResults: [Coin] = []
        
        if selectedFilters.isEmpty {
            filteredResults = self.coins
        } else {
            var addedSymbols = Set<String>()
            
            for coin in self.coins {
                for filter in selectedFilters {
                    var matches = true
                    if let isActive = filter.isActive {
                        matches = matches && (coin.isActive == isActive)
                    }
                    if let type = filter.type {
                        matches = matches && (coin.type == type)
                    }
                    if let isNew = filter.isNew {
                        matches = matches && (coin.isNew == isNew)
                    }
                    
                    if matches, !addedSymbols.contains(coin.symbol ?? "") {
                        filteredResults.append(coin)
                        addedSymbols.insert(coin.symbol ?? "")
                        break
                    }
                }
            }
        }
        
        let search = search.trimmed()
        if !search.isEmpty {
            filteredResults = filteredResults.filter {
                ($0.name ?? "").lowercased().contains(search.lowercased()) || ($0.symbol ?? "").lowercased().contains(search.lowercased())
            }
        }
        
        filteredCoins = filteredResults
    }
        
    func searchCoins(with search: String = "") {
        filterCoins(with: search)
    }
    
    func update(filter: CoinFilter, index: Int) {
        guard index >= 0 && index < filters.count else { return }
        self.filters[index] = filter
        self.filterCoins()
    }
}
