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
    func openProductEdit(product: Product)
    func close()
}

final class ProductDetailRouterImp {
    
    unowned let viewController: ProductDetailViewController
    
    init(viewController: ProductDetailViewController) {
        self.viewController = viewController
    }
}

extension ProductDetailRouterImp: ProductDetailRouter {
    
    func openSeller(product: Product) {
        let sellerVC: SellerInfoViewController = UIStoryboard.createViewController()
        
        sellerVC.presenter.setProduct(product)
        
        viewController.present(sellerVC, animated: true, completion: nil)
    }
    
    func openProductEdit(product: Product) {
        let editVC: EditProductViewController
        editVC = UIStoryboard.createViewController()
        
        editVC.presenter.setState(.edit(product: product))
        
        let navigationController = viewController.presentingViewController as? UINavigationController
        
        viewController.dismiss(animated: true) {
            navigationController?.pushViewController(editVC, animated: true)
        }
    }
    
    func close() {
        viewController.dismiss(animated: true, completion: nil)
    }
}
