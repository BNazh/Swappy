//
//  KeychainStore.swift
//  Swappy
//
//  Created by Mihail on 20/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import KeychainAccess

protocol KeychainStore: class {
    
    var accessToken: String? { get set }
    var userSellerId: String? { get set }
}

final class KeychainStoreImp {
    
    private let keychain = Keychain(service: "com.swappy")
}

extension KeychainStoreImp: KeychainStore {
    
    var accessToken: String? {
        get {
            return keychain["accessToken"]
        }
        set {
            keychain["accessToken"] = newValue
        }
    }
    
    var userSellerId: String? {
        get {
            return keychain["userSellerId"]
        }
        set {
            keychain["userSellerId"] = newValue
        }
    }
}
