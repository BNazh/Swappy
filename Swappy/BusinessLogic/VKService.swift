//
//  VKDelegate.swift
//  Swappy
//
//  Created by Mihail on 13/04/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import SwiftyVK
import UIKit

struct VKLoginResponse {
    let email: String
    let acccessToken: String
    
    init?(info: [String : String]) {
        guard let email = info["email"], let accessToken = info["access_token"] else {
            return nil
        }
        
        self.email = email
        self.acccessToken = accessToken
    }
    
    init(accessToken: String, email: String) {
        self.email = email
        self.acccessToken = accessToken
    }
}

protocol VKService: class {
    
    func login(presentingHandler: @escaping (UIViewController) -> Void,
               callback: @escaping (Result<VKLoginResponse>)  -> Void)
}

final class VKServiceImp2: SwiftyVKDelegate {
    
    var presentingHandler: ((UIViewController) -> Void)?
    
    init() {
        let appId = "5081181"
        VK.setUp(appId: appId, delegate: self)
    }
    
    func login(presentingHandler: @escaping (UIViewController) -> Void, callback: @escaping (Result<VKLoginResponse>)  -> Void) {
        self.presentingHandler = presentingHandler
        
        VK.sessions.default.logOut()
   
        VK.sessions.default.logIn(onSuccess: { info in
            guard let response = VKLoginResponse(info: info) else {
                callback(.failure(.unknown))
                return
            }
            
            callback(.success(response))
            
        }) { error in
            callback(.failure(.unknown))
        }
    }
    
    func vkNeedsScopes(for sessionId: String) -> Scopes {
        return [.email, .offline]
    }
    
    func vkNeedToPresent(viewController: VKViewController) {
        presentingHandler?(viewController)
    }
}
