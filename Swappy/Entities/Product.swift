//
//  Product.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 07/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

struct Product: Decodable {
    
    let id: String
    let images: [String]
    let size: String
    let name: String
    let description: String
    let price: Price
    let city: String
    let isSoldOut: Bool
    let isActive: Bool
    let seller: User
    let contactPhone: String
}
