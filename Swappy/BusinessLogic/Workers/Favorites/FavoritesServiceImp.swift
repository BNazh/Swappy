//
//  FavoritesServiceImp.swift
//  Swappy
//
//  Created by Mihail on 25/08/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Moya

final class FavoritesServiceImp {
    
    // MARK: - Properties
    
    private let provider: MoyaProvider<FavoritesTarget>
    private let productService: ProductService
    private let keychainStore: KeychainStore
    
    private var currentRequests: [SetFavoriteRequest] = []
    private var favoriteIds: [String] = []
    private var observers: [WeakRef<FavoritesObserver>] = []
    
    // MARK: - Init
    
    init(provider: MoyaProvider<FavoritesTarget>,
         productService: ProductService,
         keychainStore: KeychainStore) {
        self.provider = provider
        self.productService = productService
        self.keychainStore = keychainStore
    }
}

// MARK: - FavoritesService

extension FavoritesServiceImp: FavoritesService {
    
    func getFavoriteProducts(callback: @escaping ResultCallback<[Product]>) {
        callback(.success([]))
        // TODO: fav
//        let target = FavoritesTarget.getFavorites(userId: userId)
//
//        provider.requestDecodable(target) { [weak self] (result: Result<[Product]>) in
//
//            switch result {
//
//            case .success(let favoriteProducts):
//                self?.favoriteIds = favoriteProducts.map { $0.id }
//                callback(.success(favoriteProducts))
//
//            case .failure(let error):
//                callback(.failure(error))
//            }
//        }
    }
    
    func setFavorite(_ isFavorite: Bool, for productId: String, callback: @escaping ResultCallback<Void>) {
        cancelRequestIfExist(with: productId)
        
        let target = setFavoriteTarget(isFavorite: isFavorite, productId: productId)
        
        let cancellable = provider.requestDecodable(target) { [weak self] (result: Result<String?>) in
            switch result {
            case .success:
                self?.handleSetFavoriteSuccess(
                    isFavorite: isFavorite,
                    productId: productId
                )
                callback(.success)
                
            case .failure(let error):
                callback(.failure(error))
            }
        }
        
        let request = SetFavoriteRequest(productId: productId, cancellable: cancellable)
        currentRequests.append(request)
    }
    
    func isFavorite(_ productId: String) -> Bool {
        return favoriteIds.contains(productId)
    }
    
    func addSetFavoriteObserver(_ observer: FavoritesObserver) {
        let weakObserver = WeakRef(value: observer)
        observers.append(weakObserver)
    }
}

// MARK: - Private

private extension FavoritesServiceImp {
    
    // MARK: - Types
    
    struct SetFavoriteRequest {
        let productId: String
        let cancellable: Cancellable
    }
    
    struct FavoriteItem: Decodable {
        let productId: String
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
    
    func handleSetFavoriteSuccess(isFavorite: Bool, productId: String) {
        if isFavorite {
            favoriteIds.insert(productId, at: 0)
        } else {
            favoriteIds.removeAll { $0 == productId }
        }
        
        observers.removeAll { $0.value == nil }
        for observer in observers {
            observer.value?.didChangeFavorite(isFavorite, for: productId)
        }
    }
}
