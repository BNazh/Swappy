//
//  ProductsNotificationCenter.swift
//  Swappy
//
//  Created by Mihail on 02/04/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Foundation

final class ProductsNotificationCenter {
    
    // MARK: - Properties
    
    static let shared = ProductsNotificationCenter()
    
    private let notificationCenter = NotificationCenter.default
    private var observers: [NSObjectProtocol] = []
    
    // MARK: - Init
    
    private init() {}
    
    // MARK: - Functions
    
    func addObserver(forName: Notification.Name, handler: @escaping (Product) -> Void) {
        
        let observer = notificationCenter.addObserver(forName: .didAddProduct, object: self, queue: .main) { notification in
            guard let product = notification.userInfo?["product"] as? Product else {
                return
            }
            
            handler(product)
        }
        
        observers.append(observer)
    }
    
    func postNotification(_ name: Notification.Name, product: Product) {
        notificationCenter.post(name: name, object: self, userInfo: ["product": product])
    }
}
