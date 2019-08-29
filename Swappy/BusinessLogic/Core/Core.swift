//
//  Core.swift
//  Swappy
//
//  Created by Mihail on 21/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Foundation

enum Core {
    static private let isProduction = false
    
    static private let baseUrl: URL = {
        if isProduction {
            return URL(string: "http://swappy.ru/")!
        } else {
            return URL(string: "http://185.185.68.48:8080/")!
        }
    }()
    
    static private let serviceString = isProduction ? "swappy-product-catalog-service/" : "warehouse/"
    
    // MARK: - Public
    
    static let authBaseUrl = baseUrl.appendingPathComponent("swappy-auth/")
    static let productsBaseUrl = baseUrl.appendingPathComponent(serviceString)
    static let categoriesBaseUrl = baseUrl.appendingPathComponent(serviceString)
    static let userBaseUrl = authBaseUrl.appendingPathComponent("api/v1/")
    
    static let restApiBaseUrl = baseUrl.appendingPathComponent("\(serviceString)api/v1/")
}
