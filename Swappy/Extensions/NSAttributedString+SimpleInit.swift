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
        
        attributes[.font] = font
        
        self.init(string: string, attributes: attributes)
    }
}

extension NSMutableAttributedString {
    
    @discardableResult
    func setAsLink(textToFind:String, linkURL: String) -> Bool {
        
        let foundRange = self.mutableString.range(of: textToFind)
        
        guard foundRange.location != NSNotFound else {
            return false
        }
        
        self.addAttribute(.link, value: linkURL, range: foundRange)
        
        return true
    }
}

extension String {
    
    func appendBolded(_ boldedString: String, fontSize: CGFloat) -> NSAttributedString {
        let textFont = UIFont.appFont(ofSize: fontSize, style: .regular)
        let result = NSMutableAttributedString(string: self, font: textFont)
        
        let boldedFont = UIFont.appFont(ofSize: fontSize, style: .bold)
        let boldedText = NSAttributedString(string: boldedString, font: boldedFont)
        result.append(boldedText)
        
        return result
    }
}
