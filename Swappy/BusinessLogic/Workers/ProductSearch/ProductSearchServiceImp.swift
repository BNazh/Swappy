//
//  ProductSearchServiceImp.swift
//  Swappy
//
//  Created by Mihail on 14/09/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Moya

final class ProductSearchServiceImp {
    
    // MARK: - Properties
    
    private let provider: MoyaProvider<SearchTarget>
    private let settingsStore: KeychainStore
    
    private var currentSearchRequest: Cancellable?
    
    // MARK: - Init
    
    init(provider: MoyaProvider<SearchTarget>, settingsStore: KeychainStore) {
        self.provider = provider
        self.settingsStore = settingsStore
    }
}

// MARK: - ProductSearchService

extension ProductSearchServiceImp: ProductSearchService {
    
    func searchProducts(byName name: String,
                        category: Category?,
                        pageNumber: Int,
                        pageSize: Int,
                        callback: @escaping ResultCallback<[Product]>) {
        
        currentSearchRequest?.cancel()
        let target = SearchTarget.products(name: name, pageNumber: pageNumber, pageSize: pageSize)
        currentSearchRequest = provider.requestDecodable(target) { (result: Result<[Product]>) in
            callback(result)
        }
    }
    
    func userHistory(callback: @escaping ResultCallback<[String]>) {
        let userId = settingsStore.userSellerId ?? ""
        let target = SearchTarget.userHistory(userId: userId)
        
        provider.requestDecodable(target, callback: callback)
    }
}
