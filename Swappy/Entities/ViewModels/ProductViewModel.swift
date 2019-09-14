//
//  ProductViewModel.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 11/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

struct ProductViewModel {
    
    // MARK: - Properties
    
    let id: String
    let title: String
    let price: String
    let size: String
    let category: String
    let description: String
    let favoriteImage: UIImage
    
    let imageUrls: [String]
    
    // MARK: - Init
    
    init(product: Product, categoryName: String, isFavorite: Bool) {
        id = product.id
        
        title = product.name
        price = product.price.stringValue
        size = product.size
        description = product.description
        imageUrls = product.images
        
        category = categoryName
        
        favoriteImage = isFavorite ? #imageLiteral(resourceName: "like_on") : #imageLiteral(resourceName: "like_off")
    }
}
