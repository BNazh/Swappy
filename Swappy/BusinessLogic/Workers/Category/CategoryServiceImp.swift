//
//  CategoryServiceImp.swift
//  Swappy
//
//  Created by Mihail on 12/05/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Moya

typealias CategoryName = String

final class CategoryServiceImp {
    
    private let provider: MoyaProvider<CategoryTarget>
    
    private(set) var categories: [Category] = []
    private(set) var selectedCategoryIds: [String] = []
    
    init(provider: MoyaProvider<CategoryTarget>) {
        self.provider = provider
    }
}

extension CategoryServiceImp: CategoryService {
    
    func updateCategoryList(closure: ResultCallback<Void>?) {
        let request = CategoryTarget.getCategories
        
        provider.requestDecodable(request) { [weak self] (result: Result<[Category]>) in
            switch result {
            case .success(let categories):
                self?.saveCategories(categories)
                
                closure?(.success)
            case .failure(let error):
                closure?(.failure(error))
            }
        }
    }
    
    func category(withId id: String) -> Category? {
        return categories.first { $0.id == id }
    }
    
    func isCategorySelected(_ category: Category) -> Bool {
        return selectedCategoryIds.contains(category.id)
    }
    
    func selectCategory(_ category: Category) {
        let id = category.id
        guard !selectedCategoryIds.contains(id) else {
            return
        }
        
        selectedCategoryIds.append(id)
    }
    
    func deselectCategory(_ category: Category) {
        selectedCategoryIds.removeAll { $0 == category.id }
    }
    
    func selectAll() {
        selectedCategoryIds = categories.map { $0.id }
    }
}

private extension CategoryServiceImp {
    
    func saveCategories(_ categories: [Category]) {
        
        self.categories = categories
    }
}

