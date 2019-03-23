//
//  Price.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 07/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

struct Price: Codable {
    let value: Double
    let currency: String
    
    init(rubles: String) {
        value = Double(rubles) ?? 0
        currency = "₽"
    }
}

extension Price {
    
    var stringValue: String {
        return String(format: "%0.f ₽" , value)
    }
}
