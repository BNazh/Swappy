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
    var welcomeName: String? { get set }
    var welcomeCity: City? { get set }
}

final class KeychainStoreImp {
    
    // MARK: - Properties
    
    private let keychain = Keychain(service: "com.swappy")
    private let defaults = UserDefaults.standard
    
    // MARK: - Init
    
    init() {
        clearIfNeeded()
    }
}

// MARK: - Security

extension KeychainStoreImp: KeychainStore {
    
    var accessToken: String? {
        get {
            return keychain["accessToken"]
        }
        set {
            keychain["accessToken"] = newValue
        }
    }
}

// MARK: - UserDefaults

extension KeychainStoreImp {
    
    var userSellerId: String? {
        get {
            return keychain["userSellerId"]
        }
        set {
            keychain["userSellerId"] = newValue
        }
    }
    
    var welcomeCity: City? {
        get {
            let object = try? defaults.get(objectType: City.self, forKey: "welcomeCity")
            return object ?? nil
        }
        set {
            do {
                try defaults.set(object: newValue, forKey: "welcomeCity")
            } catch {
                defaults.removeObject(forKey: "welcomeCity")
            }
        }
    }
    
    var welcomeName: String? {
        get {
            return defaults.string(forKey: "welcomeName")
        }
        set {
            guard let newWelcomeName = newValue else {
                defaults.removeObject(forKey: "welcomeName")
                return
            }
            
            defaults.set(newWelcomeName, forKey: "welcomeName")
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
            return defaults.bool(forKey: "isNotFirstLaunch")
        }
        set {
            defaults.set(newValue, forKey: "isNotFirstLaunch")
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
        welcomeCity = nil
        welcomeName = nil

        isNotFirstLaunch = true
    }
}
