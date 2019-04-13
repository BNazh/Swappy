//
//  NotificationName+Product.swift
//  Swappy
//
//  Created by Mihail on 02/04/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Foundation

// MARK: - notifications for products changing

extension Notification.Name {
    
    static let didAddProduct = Notification.Name("didAddProduct")
    static let didUpdateProduct = Notification.Name("didUpdateProduct")
    static let didDeleteProduct = Notification.Name("didDeleteProduct")
    static let didAuth = Notification.Name("didAuth")
}
