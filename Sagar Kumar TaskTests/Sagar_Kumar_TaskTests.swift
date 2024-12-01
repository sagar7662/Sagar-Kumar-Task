//
//  Sagar_Kumar_Task.swift
//  Sagar Kumar TaskTests
//
//  Created by Sagar Kumar on 28/11/24.
//

import XCTest
@testable import Sagar_Kumar_Task

final class Sagar_Kumar_TaskTests: XCTestCase {
    
    var mockRepository: MockCoinRepository!
    var viewModel: CoinListViewModel!

    override func setUp() {
        super.setUp()
        mockRepository = MockCoinRepository()
        viewModel = CoinListViewModel(repository: mockRepository)
    }

    func testFetchCoinsSuccess() {
        let coins = [Coin(name: "Bitcoin", symbol: "BTC", type: .coin, isActive: true, isNew: false)]
        mockRepository.result = .success(coins)

        viewModel.fetchCoins()

        XCTAssertEqual(viewModel.filteredCoins.count, 1)
        XCTAssertEqual(viewModel.filteredCoins.first?.name, "Bitcoin")
        XCTAssertNil(viewModel.errorMessage)
    }

    func testFetchCoinsFailure() {
        mockRepository.result = .failure(NetworkError.noData)

        viewModel.fetchCoins()

        XCTAssertTrue(viewModel.filteredCoins.isEmpty)
        XCTAssertNotNil(viewModel.errorMessage)
    }
    
    func testFilterCoinsByActiveStatus() {
        let coins = [
            Coin(name: "Bitcoin", symbol: "BTC", type: .coin, isActive: true, isNew: false),
            Coin(name: "Ethereum", symbol: "ETH", type: .coin, isActive: false, isNew: false)
        ]
        mockRepository.result = .success(coins)
        
        viewModel.fetchCoins()
        viewModel.filters[0].isSelected = true
        viewModel.filterCoins()
        
        XCTAssertEqual(viewModel.filteredCoins.count, 1)
        XCTAssertEqual(viewModel.filteredCoins.first?.name, "Bitcoin")
    }
    
    func testSearchCoins() {
        let coins = [
            Coin(name: "Bitcoin", symbol: "BTC", type: .coin, isActive: true, isNew: false),
            Coin(name: "Ethereum", symbol: "ETH", type: .coin, isActive: true, isNew: true)
        ]
        mockRepository.result = .success(coins)
        
        viewModel.fetchCoins()
        viewModel.searchCoins(with: "BTC")
        
        XCTAssertEqual(viewModel.filteredCoins.count, 1)
        XCTAssertEqual(viewModel.filteredCoins.first?.name, "Bitcoin")
    }
}
