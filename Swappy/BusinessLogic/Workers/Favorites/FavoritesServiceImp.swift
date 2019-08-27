//
//  FavoritesServiceImp.swift
//  Swappy
//
//  Created by Mihail on 25/08/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Moya

final class FavoritesServiceImp {
    
    // MARK: - FavoriteItem
    
    private struct FavoriteItem: Decodable {
        let productId: String
    }
    
    // MARK: - Properties
    
    private let provider: MoyaProvider<FavoritesTarget>
    private let productService: ProductService
    private let notificationCenter: ProductsNotificationCenter
    private let keychainStore: KeychainStore
    
    private var currentRequests: [SetFavoriteRequest] = []
    
    private var favoriteItems: [FavoriteItem] = []
    private var favoriteProducts: [Product] = []
    
    // MARK: - Init
    
    init(provider: MoyaProvider<FavoritesTarget>,
         productService: ProductService,
         notificationCenter: ProductsNotificationCenter,
         keychainStore: KeychainStore) {
        self.provider = provider
        self.notificationCenter = notificationCenter
        self.keychainStore = keychainStore
    }
}

// MARK: - FavoritesService

extension FavoritesServiceImp: FavoritesService {
    
    func getFavoriteProducts(callback: @escaping ResultCallback<[Product]>) {
        let target = FavoritesTarget.getFavorites(userId: userId)
        
        provider.requestDecodable(target) { [weak self] (result: Result<[Product]>) in
            
            switch result {
                
            case .success(let favoriteItems):
                self?.favoriteItems = favoriteItems
                
                
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
    
    func setFavorite(_ isFavorite: Bool, for productId: String, callback: @escaping ResultCallback<Void>) {
        cancelRequestIfExist(with: productId)
        
        let target = setFavoriteTarget(isFavorite: isFavorite, productId: productId)
        
        let cancellable = provider.requestDecodable(target) { [weak self] (result: Result<String?>) in
            switch result {
            case .success:
                callback(.success)
            case .failure(let error):
                callback(.failure(error))
            }
        }
        
        let request = SetFavoriteRequest(productId: productId, cancellable: cancellable)
        currentRequests.append(request)
    }
    
    func isProductFavorite(_ product: Product) -> Bool {
        return favoriteProducts.contains { $0.id == product.id }
    }
}

// MARK: - Private

private extension FavoritesServiceImp {
    
    // MARK: - Types
    
    struct SetFavoriteRequest {
        let productId: String
        let cancellable: Cancellable
    }
    
    // MARK: - Properties
    
    var userId: String {
        return keychainStore.userSellerId ?? ""
    }
    
    // MARK: - Functions
    
    func cancelRequestIfExist(with productId: String) {
        let request = currentRequests.first { $0.productId == productId }
        request?.cancellable.cancel()
        currentRequests.removeAll(where: { $0.cancellable.isCancelled })
    }
    
    func setFavoriteTarget(isFavorite: Bool, productId: String) -> FavoritesTarget {
        if isFavorite {
            return .addFavorite(userId: userId, productId: productId)
        } else {
            return .deleteFavorite(userId: userId, productId: productId)
        }
    }
}
