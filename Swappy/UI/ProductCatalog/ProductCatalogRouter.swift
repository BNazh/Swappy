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
}

final class ProductCatalogRouterImp {
    
    let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension ProductCatalogRouterImp: ProductCatalogRouter {
    func openProductDetail(product: Product) {
        let productDetail: ProductDetailViewController = UIStoryboard.createViewController()
        
        productDetail.presenter.setProduct(product)
        
        productDetail.modalPresentationStyle = .currentContext
        productDetail.view.backgroundColor = .clear
        viewController.navigationController?.present(productDetail, animated: true, completion: nil)
    }
}
