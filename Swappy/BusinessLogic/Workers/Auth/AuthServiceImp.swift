//
//  AuthServiceImp.swift
//  Swappy
//
//  Created by Mihail on 19/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Moya

final class AuthServiceImp {
    
    // MARK: - Properties
    
    let provider = MoyaProvider<AuthTarget>()
}

extension AuthServiceImp: AuthService {
    
    func requestSmsVerificationCode(for phone: String) {
        let request = AuthTarget.requestSmsVerification(phone: phone)
        provider.requestDecodable(request) { result in
            clo
        }
    }
}
