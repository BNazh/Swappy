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
    
    var currentUser: User? {
        let id = keychain.userSellerId ?? ""
        return database.getItem(withId: id)
    }
    
    var currentPhone: String? {
        return currentUser?.phone ?? keychain.phone
    }
    
    var currentFullName: String? {
        return currentUser?.fullName ?? keychain.welcomeName
    }
    
    var currentCity: City? {
        return City(title: currentUser?.city) ?? keychain.welcomeCity
    }
    
    func updateUser(name: String, avatar: String?, city: String?, callback: @escaping ResultCallback<User>) {
        let id = keychain.userSellerId ?? ""
        let user = userRequestObject(name: name, avatar: avatar, city: city)
        let request = UserTarget.updateUser(id: id, user: user)
        
        provider.requestDecodable(request) { [weak self] (result: Result<User>) in
            switch result {
            case .success(let user):
                self?.database.addItem(user)
                callback(.success(user))
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
    
    func logout() {
        keychain.clear()
    }
}

// MARK: - Private

extension UserServiceImp {
    
    func userRequestObject(name: String, avatar: String?, city: String?) -> UserTarget.UserRO {
        var splitName = name.split(separator: " ")
        let firstName = String(splitName.removeFirst())
        let lastName = splitName.joined(separator: " ")
        
        return UserTarget.UserRO(
            firstName: firstName,
            lastName: lastName,
            avatarUrl: avatar,
            city: city
        )
    }
}
