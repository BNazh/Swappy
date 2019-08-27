//
//  ProductsService.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 07/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

// TODO: скорее всего логику пагинации лучше вынести отсюда

protocol ProductService: class {
    
    var canLoadMore: Bool { get }
    var selectedCategories: [Category] { get set }
    
    func getProducts(callback:  @escaping ResultCallback<[Product]>)
    func getCurrentUserProducts(callback: @escaping ResultCallback<[Product]>)
    func getProduct(withId id: String, callback: @escaping ResultCallback<Product>)
    
    func deleteProduct(id: String,
                       callback: @escaping ResultCallback<Void>)
    
    func addProduct(_ product: ProductRO,
                    isNew: Bool,
                    callback: @escaping ResultCallback<Product>)
    
    func reset()
}
