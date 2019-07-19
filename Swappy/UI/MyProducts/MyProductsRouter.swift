//
//  MyProductsRouter.swift
//  Swappy
//
//  Created by Mihail on 17/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol MyProductsRouter: class {
    
    // MARK: - Functions
    
    func openAddProduct()
    func openProduct(_ product: Product)
    func openLoginCard()
}

final class MyProductsRouterImp {
    
    // MARK: - Properties
    
    unowned let viewController: UIViewController
    
    // MARK: - Init
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

// MARK: - MyProductsRouter

extension MyProductsRouterImp: MyProductsRouter {
    
    func openAddProduct() {
        openEditProduct(state: .add)
    }
    
    func openProduct(_ product: Product) {
        let productVC: ProductDetailViewController
        productVC = UIStoryboard.createViewController()
        
        productVC.presenter.setInitState(product: product, isOwner: true)
        
        let navigationController = viewController.navigationController
        navigationController?.pushViewController(productVC, animated: true)
    }
    
    func openLoginCard() {
        let loginCardVC: LoginCardViewController = UIStoryboard.createViewController()
        
        let tabBarController = viewController.tabBarController
        tabBarController?.present(loginCardVC, animated: true, completion: nil)
    }
}

private extension MyProductsRouterImp {
    
    func openEditProduct(state: EditProductInitState) {
        let editProductVC: EditProductViewController = UIStoryboard.createViewController()
        
        editProductVC.presenter.setState(state)
        
        let navigationController = viewController.navigationController
        navigationController?.pushViewController(editProductVC, animated: true)
    }
}
