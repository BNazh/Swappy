//
//  NotificationName+Product.swift
//  Swappy
//
//  Created by Mihail on 02/04/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Foundation



extension Notification.Name {
    
    // MARK: - notifications for products changing
    
    static let didAddProduct = Notification.Name("didAddProduct")
    static let didUpdateProduct = Notification.Name("didUpdateProduct")
    static let didDeleteProduct = Notification.Name("didDeleteProduct")
    
    // MARK: - Auth
    
    static let didAuth = Notification.Name("didAuth")
    static let didLogout = Notification.Name("didLogout")
}
