//
//  ProductDetailRouter.swift
//  Swappy
//
//  Created by Mihail on 13/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol ProductDetailRouter {
    func openSeller(seller: Seller)
}

final class ProductDetailRouterImp {
    
    unowned let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension ProductDetailRouterImp: ProductDetailRouter {
    
    func openSeller(seller: Seller) {
        let sellerVC: SellerInfoViewController = UIStoryboard.createViewController()
        
        sellerVC.presenter.setSeller(seller)
        
        viewController.present(sellerVC, animated: true, completion: nil)
    }
}
