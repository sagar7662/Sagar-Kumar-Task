//
//  CoinFilterViewModel.swift
//  Sagar Kumar Task
//
//  Created by Sagar Kumar on 29/11/24.
//

import Foundation

class CoinFilterViewModel {
    
    var filters: [CoinFilter]
    
    init(filters: [CoinFilter]) {
        self.filters = filters
    }
    
    func toggle(on index: Int) {
        guard index >= 0 && index < filters.count else { return }
        filters[index].isSelected.toggle()
    }
}
