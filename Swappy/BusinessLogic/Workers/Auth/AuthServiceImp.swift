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
    
    func requestSmsVerificationCode(for phone: String, closure: @escaping (Result<Void>) -> Void) {
        let request = AuthTarget.requestSmsVerification(phone: phone)
        provider.requestDecodable(request) { (result: Result<RequestSmsResponse>) in
            
            switch result {
            case .success:
                closure(.success)
            case .failure(let appError):
                closure(.failure(appError))
            }
        }
    }
    
    func authenticate(phone: String, code: String, closure: @escaping ResultCallback<Void>) {
        let request = AuthTarget.authenticate(phone: phone, code: code)
        
        provider.requestDecodable(request) { (result: Result<AuthResponse>) in
            switch result {
            case .success(let response):
                KeychainStore.shared.accessToken = response.accessToken
                // TODO: save user
                
                closure(.success)
                
            case .failure(let appError):
                closure(.failure(appError))
            }
        }
    }
}

private struct RequestSmsResponse: Decodable {
    let phone: String
}

private struct AuthResponse: Decodable {
    let accessToken: String
    let user: User
}
