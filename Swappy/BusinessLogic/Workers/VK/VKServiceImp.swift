//
//  VKServiceImp.swift
//  Swappy
//
//  Created by Mihail on 14/04/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import VK_ios_sdk

final class VKServiceImp: NSObject {
    
    private let sdkInstance: VKSdk
    private var callback: ((Result<VKLoginResponse>) -> Void)?
    private var presentingHandler: ((UIViewController) -> Void)?
    
    override init() {
        let appId = "5081181"
        sdkInstance = VKSdk.initialize(withAppId: appId)
        
        super.init()
        
        sdkInstance.register(self)
        sdkInstance.uiDelegate = self
    }
}

extension VKServiceImp: VKService {
    
    func login(presentingHandler: @escaping (UIViewController) -> Void, callback: @escaping (Result<VKLoginResponse>)  -> Void) {
        self.presentingHandler = presentingHandler
        self.callback = callback
        
        let scopes = ["email"]
        
        VKSdk.forceLogout()
        VKSdk.authorize(scopes)
        
    }
}

extension VKServiceImp: VKSdkDelegate {
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        guard
            let accessToken = result.token?.accessToken,
            let email = result.token?.email else {
                
            callback?(.failure(.unknown))
            return
        }
    
        let response = VKLoginResponse(accessToken: accessToken, email: email)
        callback?(.success(response))
    }
    
    func vkSdkUserAuthorizationFailed() {
        callback?(.failure(.unknown))
    }
}

extension VKServiceImp: VKSdkUIDelegate {
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        presentingHandler?(controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        
    }
}
