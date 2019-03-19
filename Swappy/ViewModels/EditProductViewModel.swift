//
//  EditProductViewModel.swift
//  Swappy
//
//  Created by Mihail on 19/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

struct EditProductViewModel {
    
    // MARK: - Properties
    
    let title: String
    let description: String
    let size: String
    let price: String
    let contactInfo: String
    let category: String
    
    // MARK: - Init
    
    init(product: Product) {
        title = product.name
        description = product.description
        size = product.size
        price = product.price.stringValue
        contactInfo = product.contactPhone
        category = "" // TODO
    }
}
