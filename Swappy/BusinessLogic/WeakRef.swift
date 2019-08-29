//
//  WeakRef.swift
//  Swappy
//
//  Created by Mihail on 28/08/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

class WeakRef<T> where T: AnyObject {
    
    private(set) weak var value: T?
    
    init(value: T?) {
        self.value = value
    }
}
