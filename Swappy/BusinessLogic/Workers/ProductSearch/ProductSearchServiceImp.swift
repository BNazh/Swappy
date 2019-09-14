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
    
    let provider: MoyaProvider<SearchTarget>
    let settingsStore: KeychainStore
    
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
                        callback: @escaping ([Product]) -> Void) {
        let target = SearchTarget.products(name: name, pageNumber: pageNumber)
        provider.requestDecodable(target) { (result: Result<[Product]>) in
            
        }
    }
    
    func userHistory() -> [String] {
        
    }
}
