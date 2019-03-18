//
//  UIFont.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 07/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

extension UIFont {
    
    // MARK: - Corpid font
    
    enum CorpidFontStyle {
        case
        light,
        regular,
        bold
        
        var name: String {
            // TODO:
            switch self {
            case .regular:
                return "Helvetica"
            case .light:
                return "Helvetica-Light"
            default:
                return "Helvetica-Bold"
            }
            
        }
    }
    
    static func appFont(ofSize size: CGFloat, style: UIFont.Weight = .regular) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: style)
    }
}
