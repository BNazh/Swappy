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
    func showProduct(with id: String)
}

final class SearchResultsPresenterImp {
    
    // MARK: - Properties
    
    private let view: SearchResultsView
    private let router: SearchResultsRouter
    private let searchService: ProductSearchService
    private let pagerService: PagerService
    
    // MARK: - Init
    
    init(searchService: ProductSearchService,
         pagerService: PagerService) {
        self.searchService = searchService
        self.pagerService = pagerService
    }
}

// MARK: - SearchResultsPresenter

extension SearchResultsPresenterImp: SearchResultsPresenter {
    
    func showSearchHistory() {
        
    }
    
    func showProducts(searchString: String) {
        
    }
    
    func showProduct(with id: String) {
        
    }
}
