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
    
    var categories: [CategoryName] { get }
    var selectedCategories: [CategoryName] { get }
    
    // MARK: - Functions
    
    func updateCategoryList(closure: @escaping ResultCallback<Void>)
    
    func selectCategory(_ category: CategoryName)
    func deselectCategory(_ category: CategoryName)
    
    func selectAll()
}
