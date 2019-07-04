//
//  ProductCellViewModel.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 07/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

struct ProductCellViewModel {
    
    let id: String
    
    let imageURL: URL?
    
    let title: NSAttributedString
    let city: String
    let price: String
    
    init(_ product: Product) {
        if let firstImageString = product.images.first {
            imageURL = URL(string: firstImageString)
        } else {
            imageURL = nil
        }
        
        id = product.id
        let name = product.name.trimmingCharacters(in: .newlines)
        let size = product.size.trimmingCharacters(in: .newlines)
        title = name.appendBolded(" \(size)", fontSize: 15)
        city = product.city
        price = product.price.stringValue
    }
}

// FIXME: dirty cell height calculation

extension ProductCellViewModel {
    
    func cellHeight(withWidth width: CGFloat) -> CGFloat {
        let priceHeight: CGFloat = 22
        let spaces: CGFloat = 8 + 16 + 4 + 4
        let imageHeight = width - 8 - 8
        
        return imageHeight + priceHeight + titleHeight(width: width) + spaces
    }
    
    func titleHeight(width: CGFloat) -> CGFloat {
        
        let maxHeight: CGFloat = 54
        let maxRect = CGSize(width: width, height: maxHeight)
        let boundingRect = title.boundingRect(with: maxRect,
                                              options: .usesLineFragmentOrigin,
                                              context: nil)
        return boundingRect.size.height + 2
    }
}
