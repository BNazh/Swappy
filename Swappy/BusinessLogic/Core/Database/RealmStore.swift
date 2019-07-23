//
//  RealmStore.swift
//  Swappy
//
//  Created by Mihail on 01/04/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import RealmSwift

final class RealmStore {
    
    private let realm: Realm
    
    init() {
        realm = try! Realm()
    }
}

extension RealmStore: DatabaseStore {
    
    func getItems<T>() -> [T] where T : Plain {
        let array = realm.objects(T.RealmType.self).asPlain
        return array
    }
    
    func getItems<T>(predicate: (T) -> Bool) -> [T] where T : Plain {
        return []
    }
    
    func getItem<T>(withId id: String) -> T? where T : Plain {
        let object = realm.object(ofType: T.RealmType.self, forPrimaryKey: \T.id)
        return object?.asPlain
    }
    
    func addItem<T>(_ item: T) where T : Plain {
        try? realm.write {
            let object = item.asObject
            realm.add(object)
        }
    }
    
    func addItems<T>(_ items: [T]) where T : Plain {
        try? realm.write {
            let objects = items.asObjects
            realm.add(objects)
        }
    }
    
    func updateItem<T>(_ item: T) where T : Plain {
        
    }
    
    func deleteItem<T>(_ item: T) where T : Plain {
        realm.delete(item.asObject)
    }
}
