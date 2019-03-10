//
//  ProductsCatalogWorkerImp.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 07/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Moya

final class ProductCatalogWorkerImp {
    
    let provider = MoyaProvider<SwappyService>()
    
    var pageNumber = 0
    let pageSize = 10
    
    var canLoadMore = true
}

extension ProductCatalogWorkerImp: ProductCatalogWorker {
    
    func getProducts(callback: @escaping ResultCallback<[Product]>) {
        
        let target = SwappyService.products(pageNumber: pageNumber, pageSize: pageSize)

        provider.requestDecodable(target) { [weak self] (response: Result<[Product]>) in
            if let products = response.value {
                self?.pageNumber += 1
                self?.canLoadMore = products.count == self?.pageSize
            }
            
            callback(response)
        }
    }
    
    func reset() {
        pageNumber = 0
    }
}
