//
//  SellerInfoViewModel.swift
//  Swappy
//
//  Created by Mihail on 13/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

struct SellerInfoViewModel {
    let id: String
    let phone: String
    let vkId: String
    
    init(seller: Seller) {
        self.id = seller.id
        self.phone = seller.phone
        self.vkId = seller.vkId
    }
}
