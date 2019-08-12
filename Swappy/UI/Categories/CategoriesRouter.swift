//
//  CategoriesRouter.swift
//  Swappy
//
//  Created by Mihail on 31/07/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol CategoriesRouter {
    
    func openProductCatalog(category: Category)
}

final class CategoriesRouterImp {
    
    // MARK: - Properties
    
    private unowned let viewController: UIViewController
    
    // MARK: - Init
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

// MARK: - CategoriesRouter protocol

extension CategoriesRouterImp: CategoriesRouter {
    
    func openProductCatalog(category: Category) {
        let catalogVC: ProductCatalogViewController = UIStoryboard.createViewController()
        
        catalogVC.presenter.setCategoryMode(with: category)
        
        let navigationController = viewController.navigationController
        navigationController?.pushViewController(catalogVC, animated: true)
    }
}
