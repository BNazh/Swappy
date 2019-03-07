//
//  NSAttributedString+SimpleInit.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 07/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

extension NSAttributedString {
    convenience init(string: String, font: UIFont) {
        var attributes: [NSAttributedString.Key: Any] = [:]
        
        attributes[NSAttributedString.Key.font] = font
        
        self.init(string: string, attributes: attributes)
    }
}

extension String {
    
        func appendBolded(_ boldedString: String) -> NSAttributedString {
        let fontSize: CGFloat = 15

        let textFont = UIFont.appFont(ofSize: fontSize, style: .regular)
        let result = NSMutableAttributedString(string: self, font: textFont)
        
        let boldedFont = UIFont.appFont(ofSize: fontSize, style: .bold)
        let boldedText = NSAttributedString(string: boldedString, font: boldedFont)
        result.append(boldedText)
        
        return result
    }
}
