//
//  PagerService.swift
//  Swappy
//
//  Created by Mihail on 14/09/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//


protocol PagerDelegate: class {
    func loadPage(page: Int, pageSize: Int, callback: ResultCallback<[Product]>)
}

class PagerService {
    
    // MARK: - Properties
    
    var delegate: PagerDelegate?
    
    private(set) var canLoadMore = true
    private(set) var isLoading = false
    private(set) var items: [Product] = []
    
    private var pageSize: Int = 10
    private var page: Int = 0
    
    // MARK: - Functions
    
    func loadMoreIfNeeded(callback: ResultCallback<[Product]>) {
        guard canLoadMore, !isLoading else {
            return
        }
        
        loadMore(callback: callback)
    }
    
    func loadMore(callback: ResultCallback<[Product]>) {
        isLoading = true
        
        delegate?.loadPage(page: page, pageSize: pageSize, callback: { [weak self] result in
            self?.isLoading = false
            
            self?.handleProductsResult(result)
            callback(result)
        })
    }
    
    func refresh(callback: ResultCallback<[Product]>) {
        reset()
        
        loadMoreIfNeeded(callback: callback)
    }
    
    func reset() {
        page = 0
        canLoadMore = true
    }
    
    func handleProductsResult(_ result: Result<[Product]>) {
        guard let products = result.value else {
            return
        }
        
        page += 1
        canLoadMore = products.count == pageSize
    }
}
