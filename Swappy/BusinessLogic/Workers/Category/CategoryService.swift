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
    
    var categories: [String] { get }
    var selectedCategories: [String] { get }
    
    // MARK: - Functions
    
    func updateCategoryList(closure: @escaping ResultCallback<Void>)
    
    func selectCategory(_ category: String)
    func deselectCategory(_ category: String)
    
    func selectAll()
}
