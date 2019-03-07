//
//  Price.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 07/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

struct Price: Decodable {
    let value: Double
    let currency: String
}

extension Price {
    
    var stringValue: String {
        return String(format: "%0.f ₽" , value)
    }
}
