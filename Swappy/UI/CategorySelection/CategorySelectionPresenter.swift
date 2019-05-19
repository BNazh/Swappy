//
//  CategorySelectionPresenter.swift
//  Swappy
//
//  Created by Mihail on 12/05/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol CategorySelectionDelegate: class {
    
    func didSelectCategory(_ category: Category)
}

protocol CategorySelectionPresenter: class {
    
    // MARK: - Properties
    
    var delegate: CategorySelectionDelegate? { get set }
    var selectedCategory: Category? { get set }
    
    // MARK: - Functions
    
    func showCategories()
    func selectCategory(at index: Int)
    func saveSelectedCategory()
}

final class CategorySelectionPresenterImp {
    
    // MARK: - Properties
    
    unowned let view: CategorySelectionView
    let service: CategoryService
    
    let categories: [Category]
    var selectedCategory: Category?
    
    var delegate: CategorySelectionDelegate?
    
    // MARK: - Init
    
    init(view: CategorySelectionView, service: CategoryService) {
        self.view = view
        self.service = service
        
        categories = service.categories
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
        guard let selectedCategory = selectedCategory else { return }
        
        delegate?.didSelectCategory(selectedCategory)
    }
}

private extension CategorySelectionPresenterImp {
    
    func cellModel(from category: Category) -> CategoryCellViewModel {
        let isSelected = category.id == selectedCategory?.id
        let icon = isSelected ? #imageLiteral(resourceName: "radiobutton_on") : #imageLiteral(resourceName: "radiobutton_off")
        
        return CategoryCellViewModel(name: category.name, icon: icon, isSelected: isSelected)
    }
}
