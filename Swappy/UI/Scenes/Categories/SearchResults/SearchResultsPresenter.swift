//
//  SearchResultsPresenter.swift
//  Swappy
//
//  Created by Mihail on 16/09/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

protocol SearchResultsPresenter: class {
    
    func showSearchHistory()
    func showProducts(searchString: String)
    func refreshProducts()
    func showProduct(with id: String)
}

final class SearchResultsPresenterImp {
    
    // MARK: - Properties
    
    private let view: SearchResultsView
    private let router: SearchResultsRouter
    private let searchService: ProductSearchService
    private let pagerService: PagerService
    
    private var searchText = ""
    private var products: [Product] = []
    
    // MARK: - Init
    
    init(view: SearchResultsView,
         router: SearchResultsRouter,
         searchService: ProductSearchService,
         pagerService: PagerService) {
        self.view = view
        self.router = router
        self.searchService = searchService
        self.pagerService = pagerService
        
        pagerService.delegate = self
    }
}

// MARK: - SearchResultsPresenter

extension SearchResultsPresenterImp: SearchResultsPresenter {
    
    func showSearchHistory() {
        searchService.userHistory { [weak self] result in
            if let historyItems = result.value {
                self?.view.displaySearchHistory(historyItems)
            }
        }
    }
    
    func showProducts(searchString: String) {
        self.searchText = searchString
        
        refreshProducts()
    }
    
    func refreshProducts() {
        products = []
        pagerService.reset()
        
        loadProducts()
    }
    
    func showProduct(with id: String) {
        guard let product = products.first(where: { $0.id == id }) else { return }
        
        router.routeToProduct(product)
    }
}

// MARK: - PagerDelegate

extension SearchResultsPresenterImp: PagerDelegate {
    
    func loadPage(page: Int, pageSize: Int, callback: @escaping (Result<[Product]>) -> Void) {
        searchService.searchProducts(byName: searchText, pageNumber: page, callback: callback)
    }
}

// MARK: - Private

private extension SearchResultsPresenterImp {
    
    func loadProducts() {
        pagerService.loadMoreIfNeeded { [weak self] result in
            self?.products.append(contentsOf: result.value ?? [])
            let cellModels = self?.products.map { ProductCellViewModel($0) }
            self?.view.displayProductCells(cellModels ?? [])
        }
    }
}
