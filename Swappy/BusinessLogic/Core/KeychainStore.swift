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
    
    init() {
        clearIfNeeded()
    }
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

// MARK: - Private

private extension KeychainStoreImp {
    
    // MARK: - Properties
    
    var shouldClearKeychain: Bool {
        return !isNotFirstLaunch
    }
    
    var isNotFirstLaunch: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isNotFirstLaunch")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isNotFirstLaunch")
        }
    }
    
    // MARK: - Functions
    
    func clearIfNeeded() {
        guard shouldClearKeychain else { return }
        
        clearKeychain()
    }
    
    func clearKeychain() {
        accessToken = nil
        userSellerId = nil
        isNotFirstLaunch = true
    }
}
