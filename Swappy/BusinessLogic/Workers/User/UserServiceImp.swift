//
//  UserServiceImp.swift
//  Swappy
//
//  Created by Mihail on 25/07/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Moya

final class UserServiceImp {
    
    // MARK: - Properties
    let keychain: KeychainStore
    let database: DatabaseStore
    let provider: MoyaProvider<UserTarget>
    
    // MARK: - Init
    
    init(keychain: KeychainStore,
         database: DatabaseStore,
         provider: MoyaProvider<UserTarget>) {
        self.keychain = keychain
        self.database = database
        self.provider = provider
    }
}

// MARK: - UserService

extension UserServiceImp: UserService {
    
    var currentUser: User {
        let id = keychain.userSellerId ?? ""
        let user: User? = database.getItem(withId: id)
        
        return user ?? User.empty
    }
    
    var currentPhone: String? {
        return keychain.phone
    }
    
    func updateUser(name: String, avatar: String?, callback: @escaping ResultCallback<User>) {
        let id = keychain.userSellerId ?? ""
        let user = userRequestObject(name: name, avatar: avatar)
        let request = UserTarget.updateUser(id: id, user: user)
        
        provider.requestDecodable(request) { [weak self] (result: Result<User>) in
            switch result {
            case .success(let user):
                self?.database.updateItem(user)
                callback(.success(user))
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
    
    func logout() {
        keychain.userSellerId = nil
        keychain.accessToken = nil
        keychain.phone = nil
    }
}

// MARK: - Private

extension UserServiceImp {
    
    func userRequestObject(name: String, avatar: String?) -> UserTarget.UserRO {
        var splitName = name.split(separator: " ")
        let lastName = String(splitName.removeLast())
        let firstName = splitName.joined(separator: " ")
        
        return UserTarget.UserRO(
            firstName: firstName,
            lastName: lastName,
            avatarUrl: avatar
        )
    }
}
