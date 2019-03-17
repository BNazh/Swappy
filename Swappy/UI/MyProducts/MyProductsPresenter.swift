//
//  MyProductsPresenter.swift
//  Swappy
//
//  Created by Mihail on 17/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Foundation

protocol MyProductsPresenter: class {
    
    func loadMyProducts()
    func addProduct()
    func openProduct(withId id: String)
}

final class MyProductsPresenterImp {
    
    // MARK: Properties
    
    unowned let view: MyProductsView
    let router: MyProductsRouter
    
    private var products: [Product] = []
    
    // MARK: - Init
    
    init(view: MyProductsView, router: MyProductsRouter) {
        self.view = view
        self.router = router
    }
}

extension MyProductsPresenterImp: MyProductsPresenter {
    
    func loadMyProducts() {
        products = []
        // TODO: worker logic
        
        let viewModels = products.map { ProductCellViewModel($0) }
        view.reloadProducts(viewModels)
    }
    
    func openProduct(withId id: String) {
        let productWithId = products.first { $0.id == id }
        guard let product = productWithId else { return }
        
        router.openProduct(product)
    }
    
    func addProduct() {
        router.openAddProduct()
    }
}
