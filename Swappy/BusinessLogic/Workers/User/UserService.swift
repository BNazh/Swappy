//
//  UserService.swift
//  Swappy
//
//  Created by Mihail on 25/07/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

protocol UserService {
    
    var currentUser: User { get }
    var currentPhone: String? { get }
    
    func updateUser(name: String,
                    avatar: String?,
                    callback: @escaping ResultCallback<User>)
    
    func logout()
}
