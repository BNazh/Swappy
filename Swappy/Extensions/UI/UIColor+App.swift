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
    static let sliderBackground = UIColor.black
    
    static let whiteSmoke = UIColor(r: 248, g: 248, b: 248)
    static let munsell = UIColor(r: 242, g: 242, b: 242)
    static let trolleyGrey = UIColor(r: 121, g: 121, b: 121)
    static let coralRed = UIColor(r: 255, g: 59, b: 48)
    static let manatee = UIColor(r: 153, g: 153, b: 153)
    static let taupe = UIColor(r: 51, g: 51, b: 51)
    
    static let vkBackground = UIColor(r: 81, g: 118, b: 164)
    static let fbBackground = UIColor(r: 59, g: 89, b: 152)
}
