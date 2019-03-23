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
    private let productService: ProductService
    private let router: ProductCatalogRouter
    
    private var products: [Product] = []
    private var isLoading = false
    
    // MARK: - Init
    
    init(view: ProductCatalogView, productService: ProductService, router: ProductCatalogRouter) {
        self.view = view
        self.productService = productService
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
        
        productService.getProducts { [weak self] result in
            
            self?.isLoading = false
            
            switch result {
            case .success(let products):
                self?.handleSuccessGetProducts(products)
            case .failure(let appError):
                self?.view.showError(message: appError.localizedString)
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
        
        let viewModels = products.map { ProductCellViewModel($0) }
        view.reloadCells(viewModels)
    }
}
