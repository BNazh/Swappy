//
//  ProductsNotificationCenter.swift
//  Swappy
//
//  Created by Mihail on 02/04/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Foundation

// TODO: зарефаторить это нахер

final class ProductsNotificationCenter {
    
    // MARK: - Properties
    
    static let shared = ProductsNotificationCenter()
    
    private let notificationCenter = NotificationCenter.default
    private var observers: [NSObjectProtocol] = []
    
    // MARK: - Init
    
    private init() {}
    
    deinit {
        observers.forEach { notificationCenter.removeObserver($0) }
    }
    
    // MARK: - Functions
    
    func observeAddingProduct(handler: @escaping (Product) -> Void) {
        let observer = notificationCenter.addObserver(forName: .didAddProduct, object: self, queue: .main) { notification in
            guard let product = notification.userInfo?["product"] as? Product else {
                return
            }
            
            handler(product)
        }
        
        observers.append(observer)
    }
    
    func observeUpdatingProduct(handler: @escaping (Product) -> Void) {
        let observer = notificationCenter.addObserver(forName: .didUpdateProduct, object: self, queue: .main) { notification in
            guard let product = notification.userInfo?["product"] as? Product else {
                return
            }
            
            handler(product)
        }
        
        observers.append(observer)
    }

    func observeDeletingProduct(handler: @escaping (String) -> Void) {
        let observer = notificationCenter.addObserver(forName: .didDeleteProduct, object: self, queue: .main) { notification in
            guard let productId = notification.userInfo?["productId"] as? String else {
                return
            }
            
            handler(productId)
        }
        
        observers.append(observer)
    }
    
    func observeAuth(handler: @escaping () -> Void) {
        let observer = notificationCenter.addObserver(forName: .didAuth, object: self, queue: .main) { _ in
            handler()
        }
        
        observers.append(observer)
    }
    
    func postAddProductNotification(product: Product) {
        notificationCenter.post(name: .didAddProduct, object: self, userInfo: ["product": product])
    }
    
    func postUpdateProductNotification(product: Product) {
        notificationCenter.post(name: .didUpdateProduct, object: self, userInfo: ["product": product])
    }
    
    func postDeleteProductNotification(id: String) {
        notificationCenter.post(name: .didDeleteProduct, object: self, userInfo: ["productId": id])
    }
    
    func postAuthNotification() {
        notificationCenter.post(name: .didAuth, object: self, userInfo: nil)
    }
}
