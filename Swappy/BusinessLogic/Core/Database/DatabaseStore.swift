//
//  DatabaseStore.swift
//  Swappy
//
//  Created by Mihail on 01/04/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import RealmSwift

protocol Identifiable {
    var id: String { get }
}

protocol Plain: Identifiable {
    associatedtype RealmType: RealmObject where RealmType.PlainType == Self
    
    var asObject: RealmType { get }
}

extension Sequence where Element: Plain {
    
    var asObjects: [Element.RealmType] {
        return self.map { $0.asObject }
    }
}

protocol RealmObject: Object {
    associatedtype PlainType: Plain where PlainType.RealmType == Self
    
    var asPlain: PlainType { get }
}

extension Sequence where Element: RealmObject {
    
    var asPlain: [Element.PlainType] {
        return self.map { $0.asPlain }
    }
}

protocol DatabaseStore: AnyObject {
    
    func getItems<T: Plain>() -> [T]
    
    func getItems<T: Plain>(predicate: (T) -> Bool) -> [T]
    
    func getItem<T: Plain>(withId id: String) -> T?
    
    func addItem<T: Plain>(_ item: T)
    
    func addItems<T: Plain>(_ items: [T])
    
    func updateItem<T: Plain>(_ item: T)
    
    func deleteItem<T: Plain>(_ item: T)
}

