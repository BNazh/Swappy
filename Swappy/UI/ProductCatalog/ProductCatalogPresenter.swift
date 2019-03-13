//
//  ProductCatalogPresenter.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 07/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

protocol ProductCatalogPresenter {
    
    func loadProducts()
    func selectProduct(with id: String)
}

final class ProductCatalogPresenterImp {
    
    unowned let view: ProductCatalogView
    let productWorker: ProductCatalogWorker
    let router: ProductCatalogRouter
    
    private var products: [Product] = []
    private var isLoading = false
    
    init(view: ProductCatalogView, productWorker: ProductCatalogWorker, router: ProductCatalogRouter) {
        self.view = view
        self.productWorker = productWorker
        self.router = router
    }
}

extension ProductCatalogPresenterImp: ProductCatalogPresenter {
    
    func loadProducts() {
        guard !isLoading else {
            return
        }
        
        isLoading = true
        
        productWorker.getProducts { [weak self] result in
            
            self?.isLoading = false
            
            switch result {
            case .success(let products):
                self?.handleSuccessGetProducts(products)
                
            case .failure:
                self?.view.showError(message: "error")
            }
        }
    }
    
    func selectProduct(with id: String) {
        guard let selectedProduct = products.first(where: { $0.id == id }) else {
            return
        }
        
        router.openProductDetail(product: selectedProduct)
    }
}

private extension ProductCatalogPresenterImp {
    
    func handleSuccessGetProducts(_ newProducts: [Product]) {
        products.append(contentsOf: newProducts)
        
        let viewModels = newProducts.map { ProductCellViewModel($0) }
        view.reloadCells(viewModels)
    }
}
