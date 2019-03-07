//
//  ProductCellViewModel.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 07/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

struct ProductCellViewModel {
    
    let imageURL: URL?
    let placeholderImage: UIImage
    let title: NSAttributedString
    let city: String
    let price: String
    
    init(_ product: Product) {
        if let firstImageString = product.images.first {
            imageURL = URL(string: firstImageString)
        }
        
        placeholderImage =
        city = product
    }
}
