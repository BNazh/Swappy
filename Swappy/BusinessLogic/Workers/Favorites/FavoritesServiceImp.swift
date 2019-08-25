//
//  FavoritesServiceImp.swift
//  Swappy
//
//  Created by Mihail on 25/08/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

final class FavoritesServiceImp {
    
    // MARK: - Properties
    
    let notificationCenter: ProductsNotificationCenter
    
    // MARK: - Init
    
    init(notificationCenter: ProductsNotificationCenter) {
        self.notificationCenter = notificationCenter
    }
}

// MARK: - FavoritesService

extension FavoritesServiceImp: FavoritesService {
    
}
