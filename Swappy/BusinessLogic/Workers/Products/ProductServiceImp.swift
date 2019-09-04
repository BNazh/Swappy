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
    let notificationCenter = ProductsNotificationCenter.shared
    
    var pageNumber = 0
    let pageSize = 10
    var canLoadMore = true
    
    var selectedCategories: [Category] = []
    
    init(provider: MoyaProvider<ProductsTarget>,
         keychainStore: KeychainStore) {
        self.provider = provider
        self.keychainStore = keychainStore
    }
}

extension ProductServiceImp: ProductService {
    
    func getCurrentUserProducts(callback: @escaping ResultCallback<[Product]>) {
        let sellerId = keychainStore.userSellerId
        guard !sellerId.isEmpty else {
            callback(.failure(.auth))
            return
        }

        let request = ProductsTarget.productsBySeller(
            sellerId: sellerId,
            pageNumber: pageNumber,
            pageSize: pageSize,
            categoryIds: selectedCategories.map { $0.id }
        )

        provider.requestDecodable(request) { [weak self] (result: Result<[Product]>) in
            self?.handleProductsResult(result)
            callback(result)
        }
    }
    
    func getProducts(callback: @escaping ResultCallback<[Product]>) {
        
        let request = ProductsTarget.products(
            pageNumber: pageNumber,
            pageSize: pageSize,
            categoryIds: selectedCategories.map { $0.id }
        )

        provider.requestDecodable(request) { [weak self] (result: Result<[Product]>) in
            self?.handleProductsResult(result)
            callback(result)
        }
    }
    
    func getProduct(withId id: String, callback: @escaping (Result<Product>) -> Void) {
        let target = ProductsTarget.productById(productId: id)
        
        provider.requestDecodable(target) { (result: Result<Product>) in
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
        
        provider.requestDecodable(request) { [weak self] (result: Result<Product>) in
            switch result {
            case .success(let product):
                self?.postAddProductNotification(product: product, isNew: isNew)
                callback(.success(product))
                
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
    
    func deleteProduct(id: String, callback: @escaping ResultCallback<Void>) {
        let request = ProductsTarget.deleteProduct(id: id)
        
        // FIXME:
        provider.request(request) { [weak self] result in
            switch result {
            case .success:
                self?.notificationCenter.postDeleteProductNotification(id: id)
                callback(.success)
            case .failure:
                callback(.failure(.unknown))
            }
        }
    }
    
    func reset() {
        pageNumber = 0
        canLoadMore = true
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
    
    func postAddProductNotification(product: Product, isNew: Bool) {
        if isNew {
            notificationCenter.postAddProductNotification(product: product)
        } else {
            notificationCenter.postUpdateProductNotification(product: product)
        }
    }
}
