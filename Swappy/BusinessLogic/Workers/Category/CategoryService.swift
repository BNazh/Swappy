//
//  CategoryService.swift
//  Swappy
//
//  Created by Mihail on 12/05/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Foundation

protocol CategoryService: class {
    
    // MARK: - Properties
    
    var categories: [Category] { get }
    
    // MARK: - Functions
    
    func updateCategoryList(closure: ResultCallback<Void>?)
    
    func isCategorySelected(_ category: Category) -> Bool
    
    func selectCategory(_ category: Category)
    func deselectCategory(_ category: Category)
    
    func selectAll()
}

extension CategoryService {
    
    func updateCategoryList() {
        updateCategoryList(closure: nil)
    }
}
