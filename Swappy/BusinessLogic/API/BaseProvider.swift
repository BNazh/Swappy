//
//  BaseProvider.swift
//  Swappy
//
//  Created by Mihail on 23/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Moya

final class BaseProvider<T: TargetType>: MoyaProvider<T> {
    
    let keychainStore: KeychainStore
    
    init(keychainStore: KeychainStore) {
        self.keychainStore = keychainStore
        
        let authPlugin = AccessTokenPlugin { () -> String in
            return keychainStore.accessToken ?? ""
        }
        
        super.init(plugins: [authPlugin])
    }
}
