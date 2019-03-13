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
}

final class ProductDetailPresenterImp {
    
    let view: ProductDetailView
    var product: Product?
    
    init(view: ProductDetailView) {
        self.view = view
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
}
