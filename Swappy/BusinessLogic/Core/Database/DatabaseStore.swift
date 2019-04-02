//
//  DatabaseStore.swift
//  Swappy
//
//  Created by Mihail on 01/04/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

protocol Identifiable {
    var id: String { get }
}

class DatabaseStore<T: Identifiable> {
    
    func getItems() -> [T] {
        return []
    }
    func getItems(predicate: (T) -> Bool) -> [T] {
        return []
    }
    func getItem(withId id: String) -> T? {
        return nil
    }
    
    func addItem(_ item: T) {}
    func addItems(_ items: [T]) {}
    
    func updateItem(_ item: T) {}
    
    func deleteItem(_ item: T) {}
}

