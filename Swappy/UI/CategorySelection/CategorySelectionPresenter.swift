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
    
    unowned let view: CategorySelectionView
    
    let categories: [String]
    var selectedCategory: CategoryName = ""
    
    // MARK: - Init
    
    init(view: CategorySelectionView, service: CategoryService) {
        self.view = view
        self.categories = service.categories
    }
}

extension CategorySelectionPresenterImp: CategorySelectionPresenter {
    
    func showCategories() {
        let cellModels = categories.map { cellModel(from: $0) }
        
        view.displayCategories(cellModels)
    }
    
    func selectCategory(at index: Int) {
        selectedCategory = categories[index]
    }
    
    func saveSelectedCategory() {
        
    }
}

private extension CategorySelectionPresenterImp {
    
    func cellModel(from category: CategoryName) -> CategoryCellViewModel {
        let isSelected = category == self.selectedCategory
        let icon = isSelected ? #imageLiteral(resourceName: "radiobutton_on") : #imageLiteral(resourceName: "radiobutton_off")
        
        return CategoryCellViewModel(name: category, icon: icon, isSelected: isSelected)
    }
}
