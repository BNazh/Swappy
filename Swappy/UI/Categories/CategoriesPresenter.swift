//
//  CategoriesPresenter.swift
//  Swappy
//
//  Created by Mihail on 30/07/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

protocol CategoriesPresenter: AnyObject {
    
    func getCategories()
    func showCategory(id: String)
}

final class CategoriesPresenterImp {
    
    // MARK: - Properties
    
    private unowned let view: CategoriesView
    private let router: CategoriesRouter
    private let categoryService: CategoryService
    
    // MARK: - Init
    
    init(view: CategoriesView,
         router: CategoriesRouter,
         categoryService: CategoryService) {
        self.view = view
        self.router = router
        self.categoryService = categoryService
    }
}

// MARK: - CategoriesPresenter protocol

extension CategoriesPresenterImp: CategoriesPresenter {
    
    func getCategories() {
        let categories = categoryService.categories
        let cellModels = categories.map { CategoryCellViewModel(category: $0) }
        view.displayCells(cellModels)
    }
    
    func showCategory(id: String) {
        guard let category = categoryService.category(withId: id) else { return }
        
        router.openProductCatalog(category: category)
    }
}

// MARK: - Private


