//
//  KeychainStore.swift
//  Swappy
//
//  Created by Mihail on 20/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Foundation

protocol KeychainStore: class {
    
    var accessToken: String? { get set }
    var userSellerId: String? { get set }
}

final class KeychainStoreImp: KeychainStore  {
    
    var accessToken: String? {
        get {
            return UserDefaults.standard.string(forKey: "accessToken")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "accessToken")
        }
    }
    
    var userSellerId: String? {
        get {
            return UserDefaults.standard.string(forKey: "userSellerId")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "userSellerId")
        }
    }
}
