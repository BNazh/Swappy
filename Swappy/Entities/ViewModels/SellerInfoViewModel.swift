//
//  SellerInfoViewModel.swift
//  Swappy
//
//  Created by Mihail on 13/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

struct SellerInfoViewModel {
    let id: String
    let contactInfo: String
    
    init(seller: User, contactPhone: String) {
        self.id = seller.id ?? ""
        self.contactInfo = contactPhone
    }
}
