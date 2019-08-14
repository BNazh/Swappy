//
//  Product.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 07/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Foundation

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
    let seller: User?
    let contactPhone: String
    let category: String // Идентификатор категории, возможно нужно переименовать с CodingKeys
}

struct ProductRO: Encodable {
    var id: String? = nil
    
    let images: [String]
    let size: String
    let name: String
    let description: String
    let city: String
    let contactPhone: String
    let price: Price
    var category: String = ""
    
    let isSoldOut: Bool = true
    let isActive: Bool = true
    
    init(images: [String],
         size: String,
         name: String,
         description: String,
         contactPhone: String,
         priceString: String,
         city: String) {
        
        self.images = images
        self.size = size
        self.name = name
        self.description = description
        self.city = city
        self.contactPhone = contactPhone
        self.price = Price(priceString: priceString)
    }
}
