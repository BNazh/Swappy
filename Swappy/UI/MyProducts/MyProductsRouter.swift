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
}
