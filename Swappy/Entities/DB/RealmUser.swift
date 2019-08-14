//
//  RealmUser.swift
//  Swappy
//
//  Created by Mihail on 22/07/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import RealmSwift

final class RealmUser: Object {
    
    @objc dynamic var id: String?
    @objc dynamic var vkId: String? = nil
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String?
    @objc dynamic var avatarUrl: String?
    @objc dynamic var phone: String?
    @objc dynamic var cityTitle: String?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

extension RealmUser: RealmObject {
    
    var asPlain: User {
        
        return User(
            id: id,
            vkId: vkId,
            firstName: firstName,
            lastName: lastName,
            avatarUrl: avatarUrl,
            phone: phone,
            city: cityTitle
        )
    }
}

extension User: Plain {
    
    var asObject: RealmUser {
        let object = RealmUser()
        
        object.id = KeychainStoreImp().userSellerId // TODO: очень грязный хак, так как БЭ не присылает User.id
        object.vkId = vkId
        object.firstName = firstName
        object.lastName = lastName
        object.avatarUrl = avatarUrl
        object.phone = phone
        object.cityTitle = city
        
        return object
    }
}
