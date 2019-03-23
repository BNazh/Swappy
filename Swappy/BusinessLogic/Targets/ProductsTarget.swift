//
//  ProductsTarget.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 07/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Moya

enum ProductsTarget {
    case products(pageNumber: Int, pageSize: Int)
    case productsBySeller(sellerId: String, pageNumber: Int, pageSize: Int)
    case createProduct(product: ProductRO)
}

extension ProductsTarget: TargetType {
    
    var baseURL: URL {
        return Core.testUrl
        //return Core.baseUrl.appendingPathComponent("swappy-product-catalog-service/")
    }
    
    var path: String {
        switch self {
        case .products,
             .createProduct:
            return "products"
        case .productsBySeller(let sellerId):
            return "products/users/\(sellerId)"
        }
    }
    
    var method: Method {
        switch self {
        case .products,
             .productsBySeller:
            return .get
        case .createProduct:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .products(let pageNumber, let pageSize),
             .productsBySeller(_, let pageNumber, let pageSize):
            
            let parameters = [
                "pageNumber": pageNumber,
                "pageSize": pageSize
            ]
            
            return .requestParameters(
                parameters: parameters,
                encoding: URLEncoding.queryString
            )
            
        case .createProduct(let product):
            let body = DataRequest(data: product)
            return .requestJSONEncodable(body)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}

extension ProductsTarget: AccessTokenAuthorizable {
    
    var authorizationType: AuthorizationType {
        switch self {
        case .createProduct:
            return .bearer
        default:
            return .none
        }
    }
}

private struct DataRequest<T: Encodable>: Encodable {
    let data: T
}
