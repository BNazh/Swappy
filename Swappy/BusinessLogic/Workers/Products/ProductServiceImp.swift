//
//  ProductsCatalogWorkerImp.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 07/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Moya

final class ProductServiceImp {
    
    let provider: MoyaProvider<ProductsTarget>
    let keychainStore: KeychainStore
    
    var pageNumber = 0
    let pageSize = 10
    var canLoadMore = true
    
    init(provider: MoyaProvider<ProductsTarget>, keychainStore: KeychainStore) {
        self.provider = provider
        self.keychainStore = keychainStore
    }
}

extension ProductServiceImp: ProductService {
    
    func getCurrentUserProducts(callback: @escaping ResultCallback<[Product]>) {
        guard let sellerId = keychainStore.userSellerId else {
            callback(.failure(.auth))
            return
        }
        
        let request = ProductsTarget.productsBySeller(
            sellerId: sellerId,
            pageNumber: pageNumber,
            pageSize: pageSize
        )
        
        provider.requestDecodable(request) { [weak self] (result: Result<[Product]>) in
            self?.handleProductsResult(result)
            callback(result)
        }
    }
    
    func getProducts(callback: @escaping ResultCallback<[Product]>) {
        
        let request = ProductsTarget.products(pageNumber: pageNumber, pageSize: pageSize)

        provider.requestDecodable(request) { [weak self] (result: Result<[Product]>) in
            self?.handleProductsResult(result)
            callback(result)
        }
    }
    
    func addProduct(_ product: ProductRO, isNew: Bool, callback: @escaping ResultCallback<Product>) {
        
        let request: ProductsTarget
        if isNew {
            request = .createProduct(product: product)
        } else {
            request = .updateProduct(product: product)
        }
        
        provider.requestDecodable(request, callback: callback)
    }
    
    func deleteProduct(id: String, callback: @escaping ResultCallback<Bool>) {
        let request = ProductsTarget.deleteProduct(id: id)
        
        provider.requestDecodable(request, callback: callback)
    }
    
    func reset() {
        pageNumber = 0
    }
}

private extension ProductServiceImp {
    
    func handleProductsResult(_ result: Result<[Product]>) {
        guard let products = result.value else {
            return
        }
        
        pageNumber += 1
        canLoadMore = products.count == pageSize
    }
}
