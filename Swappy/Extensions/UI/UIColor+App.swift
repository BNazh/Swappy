//
//  UIColor+App.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 10/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
}

extension UIColor {
    
    static let backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
    static let sliderBackground = #colorLiteral(red: 0.9333333333, green: 0.7568627451, blue: 0.7568627451, alpha: 1)
    
    static let whiteSmoke = UIColor(r: 248, g: 248, b: 248)
}
