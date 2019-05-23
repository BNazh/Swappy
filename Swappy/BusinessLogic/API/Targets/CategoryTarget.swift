//
//  CategoriesTarget.swift
//  Swappy
//
//  Created by Mihail on 12/05/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Moya

enum CategoryTarget {
    case
    getCategories
}

extension CategoryTarget: TargetType {
    
    var baseURL: URL {
        return Core.categoriesBaseUrl
    }
    
    var path: String {
        return "categories/"
    }
    
    var method: Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getCategories:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}


