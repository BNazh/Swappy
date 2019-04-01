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
    
    let category = "outerwear"
    let isSoldOut: Bool = true
    let isActive: Bool = true
    
    init(images: [String], size: String, name: String, description: String, priceString: String, city: String) {
        self.images = images
        self.size = size
        self.name = name
        self.description = description
        self.city = city
        self.contactPhone = contactPhone
        
        let lettersSet = CharacterSet(charactersIn: "01234567890.").inverted
        let priceString = priceString.trimmingCharacters(in: lettersSet)
        self.price = Price(rubles: priceString)
    }
}
