//
//  DatabaseStoreImpLocal.swift
//  Swappy
//
//  Created by Mihail on 01/04/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

final class DatabaseStoreImpLocal<T: Identifiable>: DatabaseStore<T>  {
    
    // MARK: - Properties
    
    var items: [T] = []
    
    // MARK: - override functions
    
    override func getItems() -> [T] {
        return items
    }
    
    override func getItems(predicate: (T) -> Bool) -> [T] {
        return items.filter(predicate)
    }
    
    override func getItem(withId id: String) -> T? {
        return items.first { $0.id == id }
    }
    
    override func addItem(_ item: T) {
        items.append(item)
    }
    
    override func addItems(_ newItems: [T]) {
        items.append(contentsOf: newItems)
    }
    
    override func updateItem(_ updatedItem: T) {
        items = items.map { item in
            if updatedItem.id == item.id {
                return updatedItem
            } else {
                return item
            }
        }
    }
    
    override func deleteItem(_ item: T) {
        items.removeAll { $0.id == item.id }
    }
}
