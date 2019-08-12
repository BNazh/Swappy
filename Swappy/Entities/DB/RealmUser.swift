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
        let city: City?
        if let cityTitle = cityTitle {
            city = City(title: cityTitle)
        } else {
            city = nil
        }
        
        return User(
            id: id,
            vkId: vkId,
            firstName: firstName,
            lastName: lastName,
            avatarUrl: avatarUrl,
            phone: phone,
            city: city
        )
    }
}

extension User: Plain {
    
    var asObject: RealmUser {
        let object = RealmUser()
        
        object.id = id
        object.vkId = vkId
        object.firstName = firstName
        object.lastName = lastName
        object.avatarUrl = avatarUrl
        object.phone = phone
        object.cityTitle = city?.title
        
        return object
    }
}
