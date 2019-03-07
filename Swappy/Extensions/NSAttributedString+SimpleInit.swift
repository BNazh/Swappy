//
//  NSAttributedString+SimpleInit.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 07/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

extension NSAttributedString {
    
    convenience init(string: String, font: UIFont? = nil, color: UIColor? = nil) {
        
        var attributes: [NSAttributedString.Key: Any] = [:]
        
        if let font = font {
            attributes[NSAttributedString.Key.font] = font
        }
        
        if let color = color {
            attributes[NSAttributedString.Key.foregroundColor] = color
        }
        
        self.init(string: string, attributes: attributes)
    }
    
}
