//
//  ProductDetailRouter.swift
//  Swappy
//
//  Created by Mihail on 13/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol ProductDetailRouter {
    func openSeller(product: Product)
}

final class ProductDetailRouterImp {
    
    unowned let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension ProductDetailRouterImp: ProductDetailRouter {
    
    func openSeller(product: Product) {
        let sellerVC: SellerInfoViewController = UIStoryboard.createViewController()
        
        sellerVC.presenter.setProduct(product)
        
        viewController.present(sellerVC, animated: true, completion: nil)
    }
}
