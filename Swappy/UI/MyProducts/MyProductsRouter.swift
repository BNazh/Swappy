//
//  MyProductsRouter.swift
//  Swappy
//
//  Created by Mihail on 17/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol MyProductsRouter: class {
    
    func openAddProduct()
    func openProduct(_ product: Product)
    func openLoginCard()
}

final class MyProductsRouterImp {
    unowned let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension MyProductsRouterImp: MyProductsRouter {
    
    func openAddProduct() {
        openEditProduct(state: .add)
    }
    
    func openProduct(_ product: Product) {
        let productVC: ProductDetailViewController
        productVC = UIStoryboard.createViewController()
        
        productVC.presenter.setInitState(product: product, isOwner: true)
        
        viewController.present(productVC, animated: true, completion: nil)
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
