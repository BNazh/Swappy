//
//  MyProductsPresenter.swift
//  Swappy
//
//  Created by Mihail on 17/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Foundation

protocol MyProductsPresenter: class {
    
    func reloadHeader()
    func loadMyProductsIfEmpty()
    func loadMyProducts()
    func refreshMyProducts()
    func addProduct()
    func openProduct(withId id: String)
    func openProfile()
}

final class MyProductsPresenterImp {
    
    // MARK: Properties
    
    unowned let view: MyProductsView
    let router: MyProductsRouter
    let productService: ProductService
    let authService: AuthService
    let userService: UserService
    
    fileprivate var products: [Product] = []
    private var isLoading = false
    private var shouldDiscardProducts = false
    private var logoutObserver: NSObjectProtocol?
    
    // MARK: - Init
    
    init(view: MyProductsView,
         router: MyProductsRouter,
         productService: ProductService,
         authService: AuthService,
         userService: UserService) {
        self.view = view
        self.router = router
        self.productService = productService
        self.authService = authService
        self.userService = userService
        
        setupObservers()
    }
    
    deinit {
        if let observer = logoutObserver {
            NotificationCenter.default.removeObserver(observer)
        }
    }
}

extension MyProductsPresenterImp: MyProductsPresenter {
    
    func loadMyProducts() {
        guard !isLoading, productService.canLoadMore else {
            return
        }
//        guard authService.isAuthorized else {
//            productService.reset()
//            handleProducts([])
//            return
//        }
        
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
        
        productService.getCurrentUserProducts { [weak self] result in
            
            switch result {
            case .success(let products):
                self?.products = []
                self?.handleProducts(products)
            case .failure(let error):
                self?.handleGetProductsError(error)
            }
        }
    }
    
    func loadMyProductsIfEmpty() {
        guard products.isEmpty else {
            return
        }
        
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
    
    func openProfile() {
        guard authService.isAuthorized else {
            router.openLoginCard()
            return
        }
        
        router.openProfileEdit()
    }
    
    func reloadHeader() {
        let title = userService.currentFullName ?? ""
        let imageUrlString = userService.currentUser?.avatarUrl?.asUrl
        let header = HeaderViewModel(title: title, avatarURL: imageUrlString)
        view.reloadHeader(header)
    }
}

private extension MyProductsPresenterImp {
    
    func handleProducts(_ newProducts: [Product]) {
        if shouldDiscardProducts {
            products = []
        }
        
        products.append(contentsOf: newProducts)
        products.removeAll { !$0.isActive || $0.id.isEmpty } // DELETE ME
        
        reloadProductsOnView()
    }
    
    func handleGetProductsError(_ appError: AppError) {
        reloadProductsOnView()
        
        view.endRefreshing()
        switch appError {
        case .auth:
            productService.reset()
            reloadProductsOnView()
        default:
            view.showError(message: appError.localizedString)
        }
    }
    
    func setupObservers() {
        let center = ProductsNotificationCenter.shared
        
        center.observeAddingProduct { [weak self] addedProduct in
            self?.products.insert(addedProduct, at: 0)
            self?.reloadProductsOnView()
        }
        
        center.observeUpdatingProduct { [weak self] updatedProduct in
            self?.updateProduct(updatedProduct)
            self?.reloadProductsOnView()
        }
        
        center.observeDeletingProduct { [weak self] productId in
            self?.products.removeAll { $0.id == productId }
            self?.reloadProductsOnView()
        }
        
        center.observeAuth { [weak self] in
            self?.loadMyProductsIfEmpty()
        }
        
        logoutObserver = NotificationCenter.default.addObserver(forName: .didLogout, object: nil, queue: .main, using: { [weak self] _ in
            
            self?.productService.reset()
            self?.products = []
            self?.handleProducts([])
            self?.reloadHeader()
        })
    }
    
    func reloadProductsOnView() {
        let cellModels = products.map { ProductCellViewModel($0) }
        
        view.reloadProducts(cellModels)
    }
    
    func updateProduct(_ updatedProduct: Product) {
        products = products.map { product in
            if product.id == updatedProduct.id {
                return updatedProduct
            } else {
                return product
            }
        }
    }
}
