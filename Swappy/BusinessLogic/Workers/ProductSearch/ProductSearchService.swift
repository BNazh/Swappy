//
//  ProductSearchService.swift
//  Swappy
//
//  Created by Mihail on 14/09/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

protocol ProductSearchService {
    
    func searchProducts(byName name: String,
                        category: Category?,
                        pageNumber: Int,
                        pageSize: Int,
                        callback: @escaping ([Product]) -> Void)
    
    func userHistory() -> [String]
}

extension ProductSearchService {
    
    func searchProducts(byName name: String,
                        pageNumber: Int,
                        callback: @escaping ([Product]) -> Void) {
        searchProducts(byName: name, category: nil, pageNumber: pageNumber, pageSize: 10, callback: callback)
    }
}
