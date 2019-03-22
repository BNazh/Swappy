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
    
    // MARK: - Properties
    
    private unowned let view: ProductCatalogView
    private let productWorker: ProductCatalogService
    private let router: ProductCatalogRouter
    
    private var products: [Product] = []
    private var isLoading = false
    
    // MARK: - Init
    
    init(view: ProductCatalogView, productWorker: ProductCatalogService, router: ProductCatalogRouter) {
        self.view = view
        self.productWorker = productWorker
        self.router = router
    }
}

// MARK: - Presenter

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
                break
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

// MARK: - Private

private extension ProductCatalogPresenterImp {
    
    func handleSuccessGetProducts(_ newProducts: [Product]) {
        products.append(contentsOf: newProducts)
        
        let viewModels = newProducts.map { ProductCellViewModel($0) }
        view.reloadCells(viewModels)
    }
}
