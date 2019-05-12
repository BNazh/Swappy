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
    
    private let provider: MoyaProvider<CategoriesTarget>
    
    private(set) var categories: [CategoryName] = []
    private(set) var selectedCategories: [CategoryName] = []
    
    init(provider: MoyaProvider<CategoriesTarget>) {
        self.provider = provider
    }
}

extension CategoryServiceImp: CategoryService {
    
    func updateCategoryList(closure: @escaping ResultCallback<Void>) {
        let request = CategoriesTarget.getCategories
        
        provider.requestDecodable(request) { [weak self] (result: Result<[CategoryName]>) in
            switch result {
            case .success(let categories):
                self?.saveCategories(categories)
                
                closure(.success)
            case .failure(let error):
                closure(.failure(error))
            }
        }
    }
    
    func selectCategory(_ category: CategoryName) {
        guard !selectedCategories.contains(category) else {
            return
        }
        
        selectedCategories.append(category)
    }
    
    func deselectCategory(_ category: CategoryName) {
        selectedCategories.removeAll { $0 == category }
    }
    
    func selectAll() {
        selectedCategories = categories
    }
}

private extension CategoryServiceImp {
    
    func saveCategories(_ categories: [String]) {
        self.categories = categories
    }
}

