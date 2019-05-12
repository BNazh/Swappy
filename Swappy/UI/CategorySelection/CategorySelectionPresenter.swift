//
//  CategorySelectionPresenter.swift
//  Swappy
//
//  Created by Mihail on 12/05/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol CategorySelectionPresenter: class {
    
    func showCategories()
    func selectCategory(at index: Int)
    func saveSelectedCategory()
}

final class CategorySelectionPresenterImp {
    
    // MARK: - Properties
    
    let view: CategorySelectionView
    let service: CategoryService
    
    var selectedCategory: CategoryName = ""
    
    // MARK: - Init
    
    init(view: CategorySelectionView, service: CategoryService) {
        self.view = view
        self.service = service
    }
}

extension CategorySelectionPresenterImp: CategorySelectionPresenter {
    
    func showCategories() {
        let cellModels = service.categories.map { category in
            let isSelected = category == selectedCategory
            let icon = icon(for: category)
            CategoryCellViewModel(name: category, icon: <#T##UIImage#>, isSelected: <#T##Bool#>)
        }
    }
    
    func selectCategory(at index: Int) {
        
    }
    
    func saveSelectedCategory() {
        
    }
}

private extension CategorySelectionPresenterImp {
    
    func icon(for category: CategoryName) -> UIImage {
        if category == selectedCategory {
            return 
        } else {
            
        }
    }
}
