//
//  ProductsService.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 07/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Alamofire

protocol ProductService {
    
    var canLoadMore: Bool { get }
    
    func getProducts(callback:  @escaping ResultCallback<[Product]>)
    func getCurrentUserProducts(callback: @escaping ResultCallback<[Product]>)
    
    func createProduct(_ product: ProductRO,
                       callback: @escaping ResultCallback<Product>)
    
    func deleteProduct(id: String,
                       callback: @escaping ResultCallback<Bool>)
    
    func updateProduct()
}
