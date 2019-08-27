//
//  FavoritesRouter.swift
//  Swappy
//
//  Created by Mihail on 27/08/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol FavoritesRouter: AnyObject {
    
    func openProductDetail(product: Product)
}


final class FavoritesRouterImp {
    
    // MARK: - Properties
    
    private let viewController: UIViewConroller
    
    // MARK: - Init
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

// MARK: - FavoritesRouter

extension FavoritesRouterImp: FavoritesRouter {
    
    func openProductDetail(product: Product) {
        let productVC: ProductDetailViewController = UIStoryboard.createViewController()
        
        productVC.presenter.setInitState(product: product, isOwner: 
    }
}
