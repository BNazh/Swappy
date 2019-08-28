//
//  FavoritesObserver.swift
//  Swappy
//
//  Created by Mihail on 28/08/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Foundation

@objc
protocol FavoritesObserver: AnyObject {
    
    func didChangeFavorite(_ isFavorite: Bool, for productId: String)
}
