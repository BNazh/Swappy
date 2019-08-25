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
    
    private let provider: BaseProvider<FavoritesTarget>
    private let notificationCenter: ProductsNotificationCenter
    private let keychainStore: KeychainStore
    
    private var currentRequests: [SetFavoriteRequest] = []
    
    // MARK: - Init
    
    init(provider: BaseProvider<FavoritesTarget>,
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
        
    }
    
    func setFavorite(_ isFavorite: Bool, for productId: String, callback: @escaping ResultCallback<Void>) {
        cancelRequestIfExist(with: productId)
        
        let target = setFavoriteTarget(isFavorite: isFavorite, productId: productId)
        
        let cancellable = provider.requestDecodable(target) { (result: Result<String?>) in
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
}

// MARK: - Private

private extension FavoritesServiceImp {
    
    // MARK: - Types
    
    struct SetFavoriteRequest {
        let productId: String
        let cancellable: Cancellable
    }
    
    // MARK: - Functions
    
    func cancelRequestIfExist(with productId: String) {
        let request = currentRequests.first { $0.productId == productId }
        request?.cancellable.cancel()
        currentRequests.removeAll(where: { $0.cancellable.isCancelled })
    }
    
    func setFavoriteTarget(isFavorite: Bool, productId: String) -> FavoritesTarget {
        let userId = keychainStore.userSellerId ?? ""
        if isFavorite {
            return .addFavorite(userId: userId, productId: productId)
        } else {
            return .deleteFavorite(userId: userId, productId: productId)
        }
    }
}
