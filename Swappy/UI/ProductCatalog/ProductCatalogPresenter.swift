//
//  ProductCatalogPresenter.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 07/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

protocol ProductCatalogPresenter {
    
    func loadProducts()
    func refreshProducts()
    func selectProduct(with id: String)
    func showCategoryFilter()
}

final class ProductCatalogPresenterImp {
    
    // MARK: - Properties
    
    private unowned let view: ProductCatalogView
    private let productService: ProductService
    private let router: ProductCatalogRouter
    private let tracker: AnalyticsManager
    
    private var products: [Product] = []
    private var isLoading = false
    
    // MARK: - Init
    
    init(view: ProductCatalogView,
         productService: ProductService,
         categoryService: CategoryService,
         router: ProductCatalogRouter,
         tracker: AnalyticsManager) {
        self.view = view
        self.productService = productService
        self.router = router
        self.tracker = tracker
        
        productService.selectedCategories = categoryService.categories
    }
}

// MARK: - Presenter

extension ProductCatalogPresenterImp: ProductCatalogPresenter {
    
    func loadProducts() {
        guard !isLoading, productService.canLoadMore else {
            return
        }
        
        isLoading = true
        
        productService.getProducts { [weak self] result in
            self?.isLoading = false
            
            switch result {
            case .success(let products):
                self?.handleSuccessGetProducts(products)
            case .failure(let appError):
                self?.reloadProductsOnView()
                self?.view.showError(message: appError.localizedString)
            }
        }
    }
    
    func refreshProducts() {
        productService.reset()
        
        isLoading = true
        
        productService.getProducts { [weak self] result in
            self?.isLoading = false
            
            switch result {
            case .success(let products):
                self?.products = []
                self?.handleSuccessGetProducts(products)
            case .failure(let appError):
                self?.reloadProductsOnView()
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
    
    func showCategoryFilter() {
        router.openFilter(
            selectedCategories: productService.selectedCategories,
            delegate: self
        )
    }
}

extension ProductCatalogPresenterImp: CategoryFilterDelegate {
    
    func didSelectFilterCategories(_ categories: [Category], isFilterOn: Bool) {
        productService.selectedCategories = categories
        refreshProducts()
        
        view.setFilterButton(isFilterOn)
    }
}

// MARK: - Private

private extension ProductCatalogPresenterImp {
    
    var headerViewModel: HeaderViewModel {
        let 
    }
    
    func handleSuccessGetProducts(_ newProducts: [Product]) {
        products.append(contentsOf: newProducts)
        products.removeAll { !$0.isActive || $0.id.isEmpty || $0.seller == nil } // DELETE ME
        
        reloadProductsOnView()
    }
    
    func reloadProductsOnView() {
        let cellModels = products.map { ProductCellViewModel($0) }
        view.reloadCells(cellModels, header: )
    }
}
