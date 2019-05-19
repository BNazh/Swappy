//
//  CategoryFilterPresenter.swift
//  Swappy
//
//  Created by Mihail on 19/05/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol CategoryFilterDelegate: class {
    func didSelectFilterCategories(_ categories: [Category])
}

protocol CategoryFilterPresenter: class {
    
    var delegate: CategoryFilterDelegate? { get }
    
    func setSelectedCategories(_ selectedCategoryId: [String])
    
    func showCategories()
    func selectAll(_ isSelected: Bool)
    func selectCategory(withId id: String)
}

final class CategoryFilterPresenterImp {
    
    // MARK: - Properties
    
    unowned let view: CategoryFilterView
    let service: CategoryService
    
    weak var delegate: CategoryFilterDelegate?
    var filter: CategoryFilter = CategoryFilter(selectedCategories: [])
    
    // MARK: - Init
    
    init(view: CategoryFilterView, service: CategoryService) {
        self.view = view
        self.service = service
    }
}

extension CategoryFilterPresenterImp: CategoryFilterPresenter {
    
    func showCategories() {
        let categories = service.categories
        let categoryCellModels = categories.map { cellModel(for: $0) }
        
        let cellModels = [allCategoriesCellModel()] + categoryCellModels
        
        view.displayCategories(cellModels)
    }
    
    func selectAll(_ isSelected: Bool) {
        filter.selectedCategories = isSelected ? service.categories : []
    }
    
    func selectCategory(withId id: String) {
        if let categoryIndex = filter.selectedCategories.firstIndex(where: { $0.id == id }) {
            filter.selectedCategories.remove(at: categoryIndex)
        } else if let category = service.category(withId: id) {
            filter.selectedCategories.append(category)
        }
    }
}

private extension CategoryFilterPresenterImp {
    
    func cellModel(for category: Category) -> CategoryCellViewModel {
        let isSelected = filter.selectedCategories.contains { $0.id == category.id }
        let image = imageForSelectedState(isSelected)
        return CategoryCellViewModel(id: category.id, name: category.name, icon: image, isSelected: isSelected)
    }
    
    func allCategoriesCellModel() -> CategoryCellViewModel {
        let name = "Все товары"
        let isSelected = service.categories.count == filter.selectedCategories.count || filter.selectedCategories.isEmpty
        let icon = imageForSelectedState(isSelected)
        
        return CategoryCellViewModel(
            id: Constants.allCategoriesCellId,
            name: name,
            icon: icon,
            isSelected: isSelected
        )
    }
    
    func imageForSelectedState(_ isSelected: Bool) -> UIImage {
        return isSelected ? Constants.selectedImage : Constants.unselectedImage
    }
}

private extension CategoryFilterPresenterImp {
    
    enum Constants {
        static let selectedImage = #imageLiteral(resourceName: "checkbox_on")
        static let unselectedImage = #imageLiteral(resourceName: "checkbox_off")
        static let allCategoriesCellId = "ALL_PRODUCTS_CATEGORY_CELL_IDENTIFIER"
    }
}
