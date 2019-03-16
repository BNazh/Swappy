//
//  ProductDetailPresenter.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 11/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

protocol ProductDetailPresenter {
    func setProduct(_ product: Product)
    
    func showProduct()
    func showSeller()
}

final class ProductDetailPresenterImp {
    
    unowned let view: ProductDetailView
    let router: ProductDetailRouter
    
    var product: Product?
    
    init(view: ProductDetailView, router: ProductDetailRouter) {
        self.view = view
        self.router = router
    }
}

extension ProductDetailPresenterImp: ProductDetailPresenter {
    
    func setProduct(_ product: Product) {
        self.product = product
    }
    
    func showProduct() {
        guard let product = product else { return }
        
        let viewModel = ProductViewModel(product: product)
        view.showProduct(viewModel: viewModel)
    }
    
    func showSeller() {
        guard let product = product else { return }
        
        router.openSeller(product: product)
    }
}
