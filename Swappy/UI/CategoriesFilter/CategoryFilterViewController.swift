//
//  CategoriesFilter.swift
//  Swappy
//
//  Created by Mihail on 12/05/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Foundation

protocol CategoryFilterView: class {
    
    func displayCategories(_ categories: [CategoryCellViewModel])
}

final class CategoryFilterViewController: CardViewController {
    
    // MARK: - Properties
    
    var presenter: CategoryFilterPresenter!
    
    var cellModels: [CategoryCellViewModel] = []
    
    // MARK: - Functions Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}

extension CategoryFilterViewController: CategoryfilterView {
    
    
}

extension CategoryFilterViewController: UITableViewDataSource {
    
}

extension CategoryFilterViewController: UITableViewDelegate {
    
}
