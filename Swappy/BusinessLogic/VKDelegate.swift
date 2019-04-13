//
//  VKDelegate.swift
//  Swappy
//
//  Created by Mihail on 13/04/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import SwiftyVK

struct VKLoginResponse {
    let email: String
    let token: String
}

final class VKService: SwiftyVKDelegate {
    
    init() {
        let appId = "5081181"
        VK.setUp(appId: appId, delegate: self)
    }
    
    func login(callback: @escaping (Result<VKLoginResponse>)  -> Void) {
        VK.sessions.default.logIn(onSuccess: { info in
            guard let email = info["email"], let token = info["token"] else {
                callback(.failure(.unknown))
                return
            }
            
            let response = VKLoginResponse(email: email, token: token)
            callback(.success(response))
            
        }) { error in
            callback(.failure(.unknown))
        }
    }
    
    func vkNeedsScopes(for sessionId: String) -> Scopes {
        return [Scopes.email]
    }
    
    func vkNeedToPresent(viewController: VKViewController) {
        
    }
}
