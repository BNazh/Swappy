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
    private let tracker: AnalyticsManager
    
    private var callback: ((Result<VKLoginResponse>) -> Void)?
    private var presentingHandler: ((UIViewController) -> Void)?
    
    init(tracker: AnalyticsManager) {
        
        let appId = "5081181"
        sdkInstance = VKSdk.initialize(withAppId: appId)
        self.tracker = tracker
        
        super.init()
        
        sdkInstance.register(self)
        sdkInstance.uiDelegate = self
        
        // Handle authState
        NotificationCenter.default.removeObserver(sdkInstance)
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
            
            vkSdkUserAuthorizationFailed()
            return
        }
    
        tracker.track(event: .loginByVkSuccess)
        
        let response = VKLoginResponse(accessToken: accessToken, email: email)
        callback?(.success(response))
    }
    
    func vkSdkUserAuthorizationFailed() {
        tracker.track(event: .loginByVkFailure)
        
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
