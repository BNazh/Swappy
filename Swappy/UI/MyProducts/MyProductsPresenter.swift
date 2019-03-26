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
    func refreshMyProducts()
    func addProduct()
    func openProduct(withId id: String)
}

final class MyProductsPresenterImp {
    
    // MARK: Properties
    
    unowned let view: MyProductsView
    let router: MyProductsRouter
    let productService: ProductService
    let authService: AuthService
    
    fileprivate var products: [Product] = []
    private var isLoading = false
    
    // MARK: - Init
    
    init(view: MyProductsView,
         router: MyProductsRouter,
         productService: ProductService,
         authService: AuthService) {
        self.view = view
        self.router = router
        self.productService = productService
        self.authService = authService
    }
}

extension MyProductsPresenterImp: MyProductsPresenter {
    
    func loadMyProducts() {
        guard !isLoading, productService.canLoadMore else {
            return
        }
        isLoading = true
        
        productService.getCurrentUserProducts { [weak self] result in
            
            self?.isLoading = false
            
            switch result {
            case .success(let products):
                self?.handleProducts(products)
            case .failure(let error):
                self?.handleGetProductsError(error)
            }
        }
    }
    
    func refreshMyProducts() {
        productService.reset()
        loadMyProducts()
    }
    
    func openProduct(withId id: String) {
        let productWithId = products.first { $0.id == id }
        guard let selectedProduct = productWithId else { return }
        
        router.openProduct(selectedProduct)
    }
    
    func addProduct() {
        guard authService.isAuthorized else {
            router.openLoginCard()
            return
        }
        
        router.openAddProduct()
    }
}

private extension MyProductsPresenterImp {
    
    func handleProducts(_ newProducts: [Product]) {
        products.append(contentsOf: newProducts)
        
        let viewModels = products.map { ProductCellViewModel($0) }
        view.reloadProducts(viewModels)
    }
    
    func handleGetProductsError(_ appError: AppError) {
        switch appError {
        case .auth:
            router.openLoginCard()
        default:
            view.showError(message: appError.localizedString)
        }
    }
}
