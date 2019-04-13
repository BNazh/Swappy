//
//  AuthService.swift
//  Swappy
//
//  Created by Mihail on 19/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

protocol AuthService: class {
    
    var isAuthorized: Bool { get }
    
    func requestSmsVerificationCode(for phone: String, closure: @escaping ResultCallback<Void>)
    
    func authenticate(phone: String, code: String, closure: @escaping ResultCallback<Void>)
    
    func vkAuth(response: VKLoginResponse, closure: @escaping ResultCallback<Void>)
}
