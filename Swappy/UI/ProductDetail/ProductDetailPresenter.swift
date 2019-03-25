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
    func showUpdateProduct()
    
    func deleteProduct()
}

final class ProductDetailPresenterImp {
    
    unowned let view: ProductDetailView
    let router: ProductDetailRouter
    let productService: ProductService
    
    var product: Product!
    
    init(view: ProductDetailView,
         router: ProductDetailRouter,
         productService: ProductService) {
        self.view = view
        self.router = router
        self.productService = productService
    }
}

extension ProductDetailPresenterImp: ProductDetailPresenter {
    
    func setProduct(_ product: Product) {
        self.product = product
    }
    
    func showProduct() {
        let viewModel = ProductViewModel(product: product)
        view.showProduct(viewModel: viewModel)
    }
    
    func showSeller() {
        router.openSeller(product: product)
    }
    
    func showUpdateProduct() {
        router.openProductEdit(product: product)
    }
    
    func deleteProduct() {
        view.showLoading()
        
        productService
    }
}
