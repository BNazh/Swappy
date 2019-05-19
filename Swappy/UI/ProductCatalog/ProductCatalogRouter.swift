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
    
    unowned let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension ProductCatalogRouterImp: ProductCatalogRouter {
    
    func openProductDetail(product: Product) {
        let productDetail: ProductDetailViewController = UIStoryboard.createViewController()
        
        productDetail.presenter.setInitState(product: product, isOwner: false)
        
        let presentingVC = viewController.navigationController
        presentingVC?.present(productDetail, animated: true, completion: nil)
    }
    
    func openFilter(selectedCategories: [Category], delegate: CategoryFilterDelegate) {
        let filterVC: CategoryFilterViewController = UIStoryboard.createViewController()
        
        filterVC.presenter.selectedCategories = selectedCategories
        filterVC.presenter.delegate = delegate
        
        let presentingVC = viewController.navigationController
        presentingVC?.present(filterVC, animated: true, completion: nil)
    }
}
