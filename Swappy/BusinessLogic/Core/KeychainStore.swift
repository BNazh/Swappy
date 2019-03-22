//
//  KeychainStore.swift
//  Swappy
//
//  Created by Mihail on 20/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

class KeychainStore  {
    
    static let shared = KeychainStore()
    
    var accessToken: String?
    
    private init() {}
}
