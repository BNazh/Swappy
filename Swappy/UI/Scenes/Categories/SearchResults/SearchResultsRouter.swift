//
//  SearchResultsRouter.swift
//  Swappy
//
//  Created by Mihail on 16/09/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol SearchResultsRouter: class {
    
    func routeToProduct(_ product: Product)
}

final class SearchResultsRouterImp {
    
    // MARK: - Properties
    
    unowned let viewController: UIViewController
    
    // MARK: - Init
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension SearchResultsRouterImp: SearchResultsRouter {
    
    func routeToProduct(_ product: Product) {
        let productVC: ProductDetailViewController = UIStoryboard.createViewController()
        
        productVC.presenter.setInitState(product: product, isOwner: false)
        
        viewController.navigationController?.pushViewController(productVC, animated: true)
    }
}

