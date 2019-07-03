//
//  ProductViewModel.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 11/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Foundation

struct ProductViewModel {
    
    let id: String
    let title: String
    let price: String
    let size: String
    let category: String
    let description: String
    
    let imageUrls: [String]
    
    init(product: Product) {
        id = product.id
        
        title = product.name
        price = product.price.stringValue
        size = product.size
        category = product.category
        description = product.description
        imageUrls = product.images
    }
}
