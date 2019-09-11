//
//  ProductCatalogRouter.swift
//  Swappy
//
//  Created by Mihail on 12/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol Router {
    var viewController: UIViewController { get }
}

protocol ProductCatalogRouter {
    
    func openProductDetail(product: Product)
    func openFilter(selectedCategories: [Category], delegate: CategoryFilterDelegate)
}

final class ProductCatalogRouterImp {
    
    // MARK: - Properties
    
    unowned let viewController: UIViewController
    
    // MARK: - Functions
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

// MARK: - ProductCatalogRouter

extension ProductCatalogRouterImp: ProductCatalogRouter {
    
    func openProductDetail(product: Product) {
        let productDetail: ProductDetailViewController = UIStoryboard.createViewController()

        productDetail.presenter.setInitState(product: product, isOwner: false)

        let navigationVC = viewController.navigationController
        navigationVC?.pushViewController(productDetail, animated: true)
    }
    
    func openFilter(selectedCategories: [Category], delegate: CategoryFilterDelegate) {
        let filterVC: CategoryFilterViewController = UIStoryboard.createViewController()
        
        filterVC.presenter.selectedCategories = selectedCategories
        filterVC.presenter.delegate = delegate
        
        let presentingVC = viewController.tabBarController
        presentingVC?.present(filterVC, animated: true, completion: nil)
    }
}
