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
    
    let provider: MoyaProvider<AuthTarget>
    let keychainStore: KeychainStore
    
    // MARK: - Init
    
    init(provider: MoyaProvider<AuthTarget>, keychainStore: KeychainStore) {
        self.provider = provider
        self.keychainStore = keychainStore
    }
}

extension AuthServiceImp: AuthService {
    
    var isAuthorized: Bool {
        return keychainStore.accessToken != nil
    }
    
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
        
        provider.requestDecodable(request) { [weak self] (result: Result<AuthResponse>) in
            switch result {
            case .success(let response):
                self?.saveAuthResponse(response)
                closure(.success)
                
            case .failure(let appError):
                closure(.failure(appError))
            }
        }
    }
}

private extension AuthServiceImp {
    
    func saveAuthResponse(_ response: AuthResponse) {
        keychainStore.accessToken = response.accessToken
        keychainStore.userSellerId = response.swappyUser.id
    }
}

private struct RequestSmsResponse: Decodable {
    let phone: String
}

private struct AuthResponse: Decodable {
    let accessToken: String
    let swappyUser: User
}
