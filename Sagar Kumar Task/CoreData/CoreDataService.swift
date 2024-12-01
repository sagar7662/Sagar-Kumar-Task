//
//  CoreDataManage.swift
//  Sagar Kumar Task
//
//  Created by Sagar on 28/11/24.
//

import CoreData

final class CoreDataService {
    
    let persistentContainer: NSPersistentContainer

    init() {
        persistentContainer = NSPersistentContainer(name: "CryptoModel")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                print("Failed to load Core Data stack: \(error)")
            }
        }
    }

    func saveCoins(coins: [Coin]) {
        persistentContainer.performBackgroundTask { context in
            
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CryptoCoin.fetchRequest()
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            do {
                _ = try context.execute(deleteRequest)
            } catch {
                print("Failed to delete coins: \(error)")
            }

            for (index, coin) in coins.enumerated() {
                let cryptoCoin = CryptoCoin(context: context)
                cryptoCoin.name = coin.name
                cryptoCoin.symbol = coin.symbol
                cryptoCoin.isActive = coin.isActive ?? false
                cryptoCoin.type = coin.type?.rawValue
                cryptoCoin.isNew = coin.isNew ?? false
                cryptoCoin.position = Int64(index)
            }
            
            do {
                try context.save()
            } catch {
                print("Failed to save coins: \(error)")
            }
        }
    }

    func fetchCoins() -> [Coin] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<CryptoCoin> = CryptoCoin.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "position", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let results = try context.fetch(fetchRequest)
            return results.map { coin in
                Coin(
                    name: coin.name ?? "",
                    symbol: coin.symbol ?? "",
                    type: CoinType(rawValue: coin.type ?? ""),
                    isActive: coin.isActive,
                    isNew: coin.isNew
                )
            }
        } catch {
            print("Failed to fetch coins: \(error)")
            return []
        }
    }
}
