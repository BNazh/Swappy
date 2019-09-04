//
//  FavoritesServiceImp.swift
//  Swappy
//
//  Created by Mihail on 25/08/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Moya

import SwinjectStoryboard

final class FavoritesServiceImp {
    
    // MARK: - Properties
    
    private let provider: MoyaProvider<FavoritesTarget>
    private let productService: ProductService
    private let keychainStore: KeychainStore
    
    private let productsService: ProductService = SwinjectStoryboard.defaultContainer.resolve()
    
    /// Список избранных товаров
    private var favorites: [Product] = []
    
    /// Массив слабых ссылок на наблюдателей изменения списка избранных продуктов
    private var observers: [WeakRef<FavoritesObserver>] = []
    
    /// Запросы для отмены
    private var currentRequests: [SetFavoriteRequest] = []
    
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
        callback(.success(favorites))
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
            
            // TODO: fav
            self?.productsService.getProduct(withId: productId, callback: { productResult in
                switch result {
                case .success:
                    guard let product = productResult.value else {
                        callback(.failure(.unknown))
                        return
                    }
                    
                    self?.handleSetFavoriteSuccess(
                        isFavorite: isFavorite,
                        product: product // TODO: fav
                    )
                    callback(.success)
                    
                case .failure(let error):
                    callback(.failure(error))
                }
            })
        }

        let request = SetFavoriteRequest(productId: productId, cancellable: cancellable)
        currentRequests.append(request)
    }

    func isFavorite(_ productId: String) -> Bool {
        return favorites.contains { $0.id == productId }
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
    
    func handleSetFavoriteSuccess(isFavorite: Bool, product: Product) {
        if isFavorite {
            favorites.insert(product, at: 0)
        } else {
            favorites.removeAll { $0.id == product.id }
        }
        
        observers.removeAll { $0.value == nil }
        for observer in observers {
            observer.value?.didChangeFavorite(isFavorite, for: product.id)
        }
    }
}
