//
//  AuthService.swift
//  Swappy
//
//  Created by Mihail on 19/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

protocol AuthService: class {
    
    func requestSmsVerificationCode(for phone: String, closure: )
}