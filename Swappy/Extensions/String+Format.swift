//
//  String+Format.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 02/04/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Foundation

extension String {
    
    var numbersOnly: String {
        let lettersSet = CharacterSet(charactersIn: "01234567890.").inverted
        return self.trimmingCharacters(in: lettersSet)
    }
    
    var doubleValue: Double {
        let numbers = self.numbersOnly
        return Double(numbers) ?? 0
    }
}
