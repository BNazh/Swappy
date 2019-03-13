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
    let title: NSAttributedString
    let price: String
    let description: String
    
    let imageUrls: [String]
    
    init(product: Product) {
        id = product.id
        
        let name = "\(product.name) "
        let size = product.size
        title = name.appendBolded(size, fontSize: 17)
        
        price = product.price.stringValue
        description = product.description
        imageUrls = product.images
    }
}
