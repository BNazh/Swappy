//
//  Price.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 07/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Foundation

struct Price: Codable {
    
    // MARK: - Properties
    
    let value: Double
    let currency: String
    
    // MARK: - Init
    
    init(priceString: String, currency: String = AppConstants.defaultCurrency) {
        self.value = priceString.doubleValue
        self.currency = currency
    }
}

extension Price {
    
    var stringValue: String {
        return String(format: "%0.f %@" , value, AppConstants.defaultCurrency)
    }
}
