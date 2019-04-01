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
    
    init(priceString: String, currency = AppConstants.defaultCurrency) {
        let lettersSet = CharacterSet(charactersIn: "01234567890.").inverted
        let priceNumbers = priceString.trimmingCharacters(in: lettersSet)
        
        value = Double(priceNumbers) ?? 0
        self.currency = currency
    }
}

extension Price {
    
    var stringValue: String {
        return String(format: "%0.f %@" , value, currency)
    }
}
