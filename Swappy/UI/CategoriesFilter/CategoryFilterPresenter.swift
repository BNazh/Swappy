//
//  CategoryFilterPresenter.swift
//  Swappy
//
//  Created by Mihail on 19/05/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol CategoryFilterDelegate: class {
    func didSelectFilterCategories(_ categories: [Category], isFilterOn: Bool)
}

protocol CategoryFilterPresenter: class {
    
    var delegate: CategoryFilterDelegate? { get set }
    var selectedCategories: [Category] { get set }
    
    func showCategories()
    func selectCategory(withId id: String)
    func applyFilters()
    func reset()
}

final class CategoryFilterPresenterImp {
    
    // MARK: - Properties
    
    unowned let view: CategoryFilterView
    let service: CategoryService
    
    weak var delegate: CategoryFilterDelegate?
    var selectedCategories: [Category] = []
    
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
        
        let allCategoriesCellModel = self.allCategoriesCellModel()
        let cellModels = [allCategoriesCellModel] + categoryCellModels
        
        view.displayCategories(cellModels)
        view.displayResetButton(isHidden: allCategoriesCellModel.isSelected)
    }
    
    func selectCategory(withId id: String) {
        guard id != Constants.allCategoriesCellId else {
            selectAllCategories()
            return
        }
        
        if let categoryIndex = selectedCategories.firstIndex(where: { $0.id == id }) {
            selectedCategories.remove(at: categoryIndex)
        } else if let category = service.category(withId: id) {
            selectedCategories.append(category)
        }
    }
    
    func applyFilters() {
        let isFilterOn = !isAllCategoriesSelected
        delegate?.didSelectFilterCategories(selectedCategories, isFilterOn: isFilterOn)
    }
    
    func reset() {
        selectCategory(withId: Constants.allCategoriesCellId)
    }
}

private extension CategoryFilterPresenterImp {
    
    var isAllCategoriesSelected: Bool {
        return service.categories.count == selectedCategories.count
    }
    
    func cellModel(for category: Category) -> SelectionItemViewModel {
        let isSelected = selectedCategories.contains { $0.id == category.id }
        let image = imageForSelectedState(isSelected)
        return SelectionItemViewModel(id: category.id, name: category.name, icon: image, isSelected: isSelected)
    }
    
    func allCategoriesCellModel() -> SelectionItemViewModel {
        let name = "Все товары"
        let icon = imageForSelectedState(isAllCategoriesSelected)
        
        return SelectionItemViewModel(
            id: Constants.allCategoriesCellId,
            name: name,
            icon: icon,
            isSelected: isAllCategoriesSelected
        )
    }
    
    func imageForSelectedState(_ isSelected: Bool) -> UIImage {
        return isSelected ? Constants.selectedImage : Constants.unselectedImage
    }
    
    func selectAllCategories() {
        if isAllCategoriesSelected {
            selectedCategories = []
        } else {
            selectedCategories = service.categories
        }
    }
}

private extension CategoryFilterPresenterImp {
    
    enum Constants {
        static let selectedImage = #imageLiteral(resourceName: "checkbox_on")
        static let unselectedImage = #imageLiteral(resourceName: "checkbox_off")
        static let allCategoriesCellId = "ALL_PRODUCTS_CATEGORY_CELL_IDENTIFIER"
    }
}
