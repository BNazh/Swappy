//
//  Seller.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 07/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

struct User: Decodable {
    
    let id: String?
    let vkId: String?
    let firstName: String
    let lastName: String?
    let avatarUrl: String?
    let phone: String?
    let city: String?
}


// MARK: - Computed properties

extension User {
    
    var fullName: String {
        let lastName = self.lastName ?? ""
        return firstName + " " + lastName
    }
}
