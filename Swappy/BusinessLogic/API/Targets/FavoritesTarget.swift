//
//  FavoritesTarget.swift
//  Swappy
//
//  Created by Mihail on 25/08/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Moya

enum FavoritesTarget {
    case
    getFavorites(userId: String),
    addFavorite(userId: String, productId: String),
    deleteFavorite(userId: String, productId: String)
}

extension FavoritesTarget: TargetType {
    
    var baseURL: URL {
        return Core.restApiBaseUrl.appendingPathComponent("favorites/")
    }
    
    var path: String {
        switch self {
        case .getFavorites(let userId):
            return "users/\(userId)"
        case .addFavorite(let userId, let productId),
             .deleteFavorite(let userId, let productId):
            return "users/\(userId)/products/\(productId)"
        }
    }
    
    var method: Method {
        switch self {
        case .getFavorites:
            return .get
        case .addFavorite:
            return .post
        case .deleteFavorite:
            return .delete
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
}

extension FavoritesTarget: AccessTokenAuthorizable {
    
    var authorizationType: AuthorizationType {
        return .bearer
    }
}
