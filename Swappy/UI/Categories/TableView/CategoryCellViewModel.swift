//
//  CategoryCellViewModel.swift
//  Swappy
//
//  Created by Mihail on 31/07/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Foundation

struct CategoryCellViewModel {
    
    // MARK: - Properties
    
    let id: String
    let title: String
    let imageUrl: URL?
    
    // MARK: - Init
    
    init(category: Category) {
        id = category.id
        title = category.name
        
        if let image = category.image {
            imageUrl = URL(string: image)
        } else {
            imageUrl = nil
        }
    }
}
