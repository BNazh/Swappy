//
//  FavoritesService.swift
//  Swappy
//
//  Created by Mihail on 25/08/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

// MARK: - Observer

protocol FavoritesObserver: AnyObject {
    
    func didChangeFavorite(_ isFavorite: Bool, for productId: String)
}

// MARK: - Service

protocol FavoritesService: AnyObject {
    
    func isProductFavorite(_ product: Product) -> Bool
    
    func setFavorite(_ isFavorite: Bool,
                     for productId: String,
                     callback: @escaping ResultCallback<Void>)
    
    func getFavoriteProducts(callback: @escaping ResultCallback<[Product]>)
    
    func addSetFavoriteObserver(_ observer: FavoritesObserver)
}
