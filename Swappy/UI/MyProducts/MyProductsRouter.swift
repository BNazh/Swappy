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
        
    }
    
    func openProduct(_ product: Product) {
        
    }
    
    func openLoginCard() {
        let loginCardVC: LoginCardViewController = UIStoryboard.createViewController()

        viewController.present(loginCardVC, animated: true, completion: nil)
        
//        let editProductVC: EditProductViewController = UIStoryboard.createViewController()
//
//        viewController.navigationController?.pushViewController(editProductVC, animated: true)
    }
}
