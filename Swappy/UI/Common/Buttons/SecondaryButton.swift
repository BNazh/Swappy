//
//  SecondaryButton.swift
//  Swappy
//
//  Created by Mihail on 13/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

class SecondaryButton: UIButton {
    
    // MARK: - Constants
    
    private enum Constants {
        static let cornerRadius: CGFloat = 8
        static let titleLabelFont = UIFont.systemFont(ofSize: 15, weight: .semibold)
        
        enum Color {
            static let background = UIColor.whiteSmoke
            static let textColor = UIColor.black
        }
    }
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    // MARK: - Functions
    
    func commonInit() {
        layer.cornerRadius = Constants.cornerRadius
        titleLabel?.font = Constants.titleLabelFont
        
        setTitleColor(Constants.Color.textColor, for: .normal)
        backgroundColor = Constants.Color.background
    }
}
