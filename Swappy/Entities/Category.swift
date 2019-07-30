//
//  Category.swift
//  Swappy
//
//  Created by Mihail on 19/05/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Foundation

// Категория товаров
struct Category: Decodable {
    
    // MARK: - Properties
    
    let id: String
    let name: String
    let image: String
    let subcategories: [Category]?
}

// MARK: - SelectionItem

extension Category: SelectionItem {
    
    var selectionId: String {
        return id
    }
    
    var selectionTitle: String {
        return name
    }
}
