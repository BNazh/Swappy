//
//  SearchTarget.swift
//  Swappy
//
//  Created by Mihail on 14/09/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Moya

enum SearchTarget {
    case
    products(name: String, pageNumber: Int),
    userHistory(userId: String)
}

// MARK: - TargetType

extension SearchTarget: TargetType {
    
    var baseURL: URL {
        return Core.restApiBaseUrl.appendingPathComponent("search")
    }
    
    var path: String {
        switch self {
        case .products:
            return "products"
        case let .userHistory(userId):
            return "users/\(userId)/history"
        }
    }
    
    var method: Method {
        return .get
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
